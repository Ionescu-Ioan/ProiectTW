const fs = require('fs');
const path = require('path');
const sharp = require('sharp');
const { exec } = require("child_process");
const ejs = require('ejs');
const session = require('express-session');
const formidable = require('formidable');
const nodemailer = require("nodemailer");
const sassMiddleware = require('node-sass-middleware');
const { Client } = require('pg');

// https://expressjs.com/en/guide/routing.html
const express = require('express');
const { stringify } = require('querystring'); //extrage doar proprietatea stringify 
const app = express();

const { Client } = require('pg');

const client = new Client({
  connectionString: process.env.DATABASE_URL,
  ssl: {
    rejectUnauthorized: false
  }
});

client.connect();



const fetchMainCategories = async () => {
    const { rows: mainCategories } = await Client.query("select distinct(categorie) from materiale");
  
    return mainCategories.map(({ categ }) => categorie);
  };

// set the view engine to ejs
app.set('view engine', 'ejs');


app.get("*/galerie_statica.json",function(req, res){    
    client.query("select unnest(enum_range( null::categ_materiale)) as categ", function(errEnums,rezEnums){
        let categoriiMateriale = [];
        let rows = rezEnums.rows;
        rows.forEach(({categ}) => {
            if(categ) categoriiMateriale.push(categ);
        });
    res.status(403).render("pagini/403",{categoriimateriale: categoriiMateriale});});
});

// declare static directory -> https://expressjs.com/en/starter/static-files.html
app.use('/media', express.static(__dirname + '/media'));

const imaginiVerificate = (function verificaImagini(){
	const textFisier=fs.readFileSync(path.join(__dirname, "/media/json/galerie_statica.json")); //citeste tot fisierul
	const jsi=JSON.parse(textFisier); //am transformat in obiect
	const caleGalerie = path.join(__dirname, jsi.cale_galerie);
    const caleImagine = "/media/galerie_statica";
    const vectImagini=[];
  

	for (let im of jsi.imagini){
		const imVeche= path.join(caleGalerie, im.cale_fisier);//obtin claea completa (im.cale_fisier are doar numele fisierului din folderul caleGalerie)		
        const ext = path.extname(im.cale_fisier);//obtin extensia
		const numeFisier =path.basename(im.cale_fisier,ext)//obtin numele fara extensie
		const imMica=path.join(caleGalerie+"/mic/", numeFisier+"-mic"+".webp");//creez cale apentru imaginea noua; prin extensia wbp stabilesc si tipul ei
		const imMedie=path.join(caleGalerie+"/mediu/", numeFisier+"-mediu"+".webp");
        
        vectImagini.push({
            mare: path.join(caleImagine, im.cale_fisier), 
            medie: path.join(caleImagine + "/mediu", numeFisier+"-mediu"+".webp"), 
            mic: path.join(caleImagine + "/mic", numeFisier+"-mic"+".webp"), 
            titlu: im.titlu,
            descriere: im.text_descriere,
            anotimp: im.anotimp,
            copyright: im.copyright
        }); //adauga in vector un element
    
		
        if (!fs.existsSync(imMica))//daca nu exista imaginea, mai jos o voi crea
        {  
            sharp(imVeche)
            .resize(150) //daca dau doar width(primul param) atunci height-ul e proportional
            .toFile(imMica, function(err, result) {
                if(err)
                    console.log("eroare conversie",imVeche, "->", imMica, err);
            });
        }

        if (!fs.existsSync(imMedie))//daca nu exista imaginea, mai jos o voi crea
        {   sharp(imVeche)
            .resize(300) //daca dau doar width(primul param) atunci height-ul e proportional
            .toFile(imMedie, function(err, result) {         
                if(err)
                    console.log("eroare conversie",imVeche, "->", imMedie, err);
            });
        }
         
	}
    // [ {mare:cale_img_mare, mic:cale_img_mica, descriere:text}, {mare:cale_img_mare, mic:cale_img_mica, descriere:text}, {mare:cale_img_mare, mic:cale_img_mica, descriere:text}  ]
   
    return vectImagini;
})();

app.get(["*/galerie_animata_4.css", "*/galerie_animata_9.css", "*/galerie_animata_16.css"],function(req, res){
    const cssFileName = req.path.slice(11);
    const scssFileName = cssFileName.slice(0, -4) + ".scss";
    /*Atentie modul de rezolvare din acest app.get() este strict pentru a demonstra niste tehnici
    si nu pentru ca ar fi cel mai eficient mod de rezolvare*/
    res.setHeader("Content-Type","text/css");//pregatesc raspunsul de tip css
    let sirScss=fs.readFileSync("./media/scss/" + scssFileName).toString("utf-8");//citesc scss-ul cs string
    culori=["navy","black","purple","grey"]
    let culoareAleatoare =culori[Math.floor(Math.random()*culori.length)];//iau o culoare aleatoare pentru border
    let rezScss=ejs.render(sirScss,{culoare:culoareAleatoare});// transmit culoarea catre scss si obtin sirul cu scss-ul compilat
   
    fs.writeFileSync("./temp/" + scssFileName,rezScss);//scriu scss-ul intr-un fisier temporar
    exec(`sass ./temp/${scssFileName} ./temp/${cssFileName}`, (error, stdout, stderr) => {//execut comanda sass (asa cum am executa in cmd sau PowerShell)
        if (error) {
            console.log(`error: ${error.message}`);
            res.end();//termin transmisiunea in caz de eroare
            return;
        }
        if (stderr) {
            //console.log(`stderr: ${stderr}`);
            res.end();
            return;
        }

        //totul a fost bine, trimit fisierul rezultat din compilarea scss
        res.sendFile(path.join(__dirname,`temp/${cssFileName}`));
    });

});

//voi afla anotimpul curent
const anotimpuri={
    iarna: [0, 1, 11],
    primavara: [2, 3, 4],
    vara: [5, 6, 7],
    toamna: [8, 9, 10],
}

function obtineImaginiAnotimp(luna){
    //Object.keys() imi intoarce un array cu toate cheile obiectului anotimpuri
    const anotimpCurent=Object.keys(anotimpuri).find(val => anotimpuri[val].indexOf(luna) >=0);
    //cu slice trunchiez numarul de imagini care se incadreaza in anotimpul curent la 10
    return imaginiVerificate.filter(val => val.anotimp === anotimpCurent).slice(0, 10);
}

// index page
app.get(['/', '/index'], function(req, res) {
    const luna = new Date().getMonth();
    const galerie = obtineImaginiAnotimp(luna);
    const user_ip = req.headers['x-forwarded-for'] || req.connection.remoteAddress;
    client.query("select unnest(enum_range( null::categ_materiale)) as categ", function(errEnums,rezEnums){
        let categoriiMateriale = [];
        let rows = rezEnums.rows;
        rows.forEach(({categ}) => {
            if(categ) categoriiMateriale.push(categ);
        });
    res.render('pagini/index', {galerie, user_ip, categoriimateriale: categoriiMateriale});});
});


app.get(['/pagina_galerie_statica'], function(req, res) {
    const luna = new Date().getMonth();
    const galerie = obtineImaginiAnotimp(luna);
    client.query("select unnest(enum_range( null::categ_materiale)) as categ", function(errEnums,rezEnums){
        let categoriiMateriale = [];
        let rows = rezEnums.rows;
        rows.forEach(({categ}) => {
            if(categ) categoriiMateriale.push(categ);
        });
    res.render('pagini/pagina_galerie_statica', {galerie, categoriimateriale: categoriiMateriale});});
});

app.get(['/pagina_galerie_animata'], function(req, res) {
    const count = imaginiVerificate.length;
    const getRand = (max) => Math.floor(Math.random() * max); 
    const indexes = new Set();
    const vector_dimensiune_grid = [4, 9, 16];
    const nr_imagini = vector_dimensiune_grid[getRand(vector_dimensiune_grid.length)];

    // console.log(nr_imagini);
    while(indexes.size < nr_imagini)
    {
        const nr = getRand(count);
        if(imaginiVerificate[nr].titlu.length < 12 )
            indexes.add(nr);
        // indexes.add(getRand(count));
    }
    const galerie = imaginiVerificate.filter((val, key) => indexes.has(key));
    client.query("select unnest(enum_range( null::categ_materiale)) as categ", function(errEnums,rezEnums){
        let categoriiMateriale = [];
        let rows = rezEnums.rows;
        rows.forEach(({categ}) => {
            if(categ) categoriiMateriale.push(categ);
        });
    res.render('pagini/pagina_galerie_animata', {galerie, categoriimateriale: categoriiMateriale});});
});

// app.all('/media/*', function(req, res) {
//     console.log("in 403");
//     res.status(403).send('pagini/403');
// });


app.get("/produse",function(req, res){
    
    //console.log("Url:",req.url);
    //console.log("Query:", req.query.tip);
    // conditie_booleana? val_true : val_false
    var cat = req.query.categ;
    let conditie1= req.query.categ ?  " and categorie='"+req.query.categ+"'" : "";
    //console.log(conditie1);
    //daca am parametrul tip in cale (tip=cofetarie, de exemplu) adaug conditia pentru a selecta doar produsele de acel tip
    client.query("select descriere, id, nume, pret, greutate, tip_produs, categorie, cu_livrare, imagine, culoare, materiale_componente, data_adaugare from materiale where 1=1"+conditie1, function(err,rez){
     
        //console.log(rez, err);
        client.query("select unnest(enum_range( null::tipuri_materiale)) as tip, unnest(enum_range( null::categ_materiale)) as categ, unnest(enum_range( null::culori)) as culoare", function(errEnums,rezEnums){
        
            let tipuriMateriale = [];
            let categoriiMateriale = [];
            let culori = [];
            let rows = rezEnums.rows;
            rows.forEach(({tip, categ, culoare}) => {
                if(tip) tipuriMateriale.push(tip);
                if(categ) categoriiMateriale.push(categ);
                if(culoare) culori.push(culoare);
            });
         
            res.render("pagini/produse", {produse:rez.rows, tipuriMateriale, categoriimateriale: categoriiMateriale, culori, preselectedCateg:req.query.categ, Cat:cat || ""});//obiectul {a:10,b:20} poarta numele locals in ejs  (locals["a"] sau locals.a)
        });
    });
});


//pagina proprie produsului
app.get("/produs/:id_produs",function(req, res){
    console.log(req.params);
    
    const rezultat= client.query("select * from materiale where id="+req.params.id_produs, function(err,rez){
        //console.log(err, rez);
        console.log(rez.rows);
        client.query("select unnest(enum_range( null::categ_materiale)) as categ", function(errEnums,rezEnums){
            let categoriiMateriale = [];
            let rows = rezEnums.rows;
            rows.forEach(({categ}) => {
                if(categ) categoriiMateriale.push(categ);
            });
        res.render("pagini/produs", {prod:rez.rows[0], categoriimateriale:categoriiMateriale});});
    });

});


// map to template -> https://webapplog.com/url-parameters-and-routing-in-express-js/
app.get(['/:template', '/:template/*'],  function(req, res, next) {    
    const ip = req.headers['x-forwarded-for'] || req.connection.remoteAddress;
   
    let template = req.params.template;
    client.query("select unnest(enum_range( null::categ_materiale)) as categ", function(errEnums,rezEnums){
        let categoriiMateriale = [];
        let rows = rezEnums.rows;
        rows.forEach(({categ}) => {
            if(categ) categoriiMateriale.push(categ);
        });
    res.render('pagini/' + template, {user_ip: ip, categoriimateriale: categoriiMateriale}, function(err, html) {
        // handle missing template
        if (err) {
            if (err.message.indexOf('Failed to lookup view') !== -1) {
                return res.status(404).render('pagini/404',{user_ip: ip, categoriimateriale: categoriiMateriale});
            }
            throw err;
        }
        res.send(html);
    });});

});


// 500 error
app.use(function (err, req, res, next) {
    console.error(err.stack);
    res.status(500).send('A aparut o eroare! Va rugam incercati mai tarziu');
});

app.listen(8080);
console.log('Serverul a pornit!');
