const fs = require('fs');
const path = require('path');
const sharp = require('sharp');

// https://expressjs.com/en/guide/routing.html
const express = require('express');
const { stringify } = require('querystring'); //extrage doar proprietatea stringify 
const app = express();



// set the view engine to ejs
app.set('view engine', 'ejs');

// declare static directory -> https://expressjs.com/en/starter/static-files.html
app.use('/media', express.static(__dirname + '/media'));

const imaginiVerificate = (function verificaImagini(){
	const textFisier=fs.readFileSync(path.join(__dirname, "/media/json/galerie_statica.json")); //citeste tot fisierul
	const jsi=JSON.parse(textFisier); //am transformat in obiect
	const caleGalerie = path.join(__dirname, jsi.cale_galerie);
    const caleImagine = "/media/galerie_statica";
    const vectImagini=[];

	for (let im of jsi.imagini){
		const imVeche= path.join(caleGalerie, im.fisier);//obtin claea completa (im.fisier are doar numele fisierului din folderul caleGalerie)		
        const ext = path.extname(im.fisier);//obtin extensia
		const numeFisier =path.basename(im.fisier,ext)//obtin numele fara extensie
		const imMica=path.join(caleGalerie+"/mic/", numeFisier+"-mic"+".webp");//creez cale apentru imaginea noua; prin extensia wbp stabilesc si tipul ei
		const imMedie=path.join(caleGalerie+"/mediu/", numeFisier+"-mediu"+".webp");
        
        vectImagini.push({
            mare: path.join(caleImagine, im.fisier), 
            medie: path.join(caleImagine + "/mediu", im.fisier), 
            mic: path.join(caleImagine + "/mic", im.fisier), 
            anotimp: im.anotimp, 
            descriere: im.descriere
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


// index page
app.get(['/', '/index'], function(req, res) {
    const ip = req.headers['x-forwarded-for'] || req.connection.remoteAddress;
    console.log(ip);
    res.render('pagini/index', {galerie: imaginiVerificate, user_ip: ip});
});


app.get(['/pagina_galerie_statica'], function(req, res) {
    const ip = req.headers['x-forwarded-for'] || req.connection.remoteAddress;
    res.render('pagini/pagina_galerie_statica', {galerie: imaginiVerificate, user_ip: ip});
});

// app.all('/media/*', function(req, res) {
//     console.log("in 403");
//     res.status(403).send('pagini/403');
// });

// map to template -> https://webapplog.com/url-parameters-and-routing-in-express-js/
app.get(['/:template', '/:template/*'], function(req, res, next) {
    const ip = req.headers['x-forwarded-for'] || req.connection.remoteAddress;
    let template = req.params.template;
    res.render('pagini/' + template, {user_ip: ip}, function(err, html) {
        // handle missing template
        if (err) {
            if (err.message.indexOf('Failed to lookup view') !== -1) {
                return res.status(404).render('pagini/404');
            }
            throw err;
        }
        res.send(html);
    });
});


// app.all('/media', function (req, res, next) {
//     console.log('Accessing the secret section ...');
//     next() // pass control to the next handler
//   });

app.get("/media",function(req, res){    
    console.log("intra!");
    res.render("pagini"+req.url, function(err,rezultatRandare){
        if(err){
            if(err.message.includes("Failed to lookup view")){
                res.status(403).render("pagini/403");
            }
            else 
                throw err;
        }
        else{
            res.send(rezultatRandare);
        }
    });
});

// 404 status -> https://expressjs.com/en/starter/faq.html
/*app.use(function (req, res, next) {
    res.status(404).render('pagini/404');
});

//403 status
app.use(function (req, res, next) {
    res.status(403).render('pagini/403');
});
*/

// 500 error
app.use(function (err, req, res, next) {
    console.error(err.stack);
    res.status(500).send('A aparut o eroare! Va rugam incercati mai tarziu');
});

app.listen(8080);
console.log('Serverul a pornit!');
