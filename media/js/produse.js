window.addEventListener("load", function(){


    var slider = document.getElementById("inp-pret");
    var output = document.getElementById("rez-range");
    output.innerHTML = slider.value;
    
    slider.oninput = function() {
        output.innerHTML = " (pret maxim: "+this.value+" lei)";
        this.setAttribute("value", this.value);
    }

    var rng=document.getElementById("inp-pret");
    var range_min_val=document.querySelector(".range-min-val");
    var range_max_val=document.querySelector(".range-max-val");
    range_min_val.innerHTML=rng.min;
    range_max_val.innerHTML=rng.max;
	// rng.parentNode.insertBefore(document.createTextNode(rng.min),rng);
	// rng.parentNode.appendChild(document.createTextNode(rng.max));
  

    let btn=document.getElementById("filtrare");

    var ckb1=document.getElementById("check-box-orice");
    var ckb2=document.getElementById("check-box-constructii");
    var ckb3=document.getElementById("check-box-amenajari");
    ckb1.style.display="block";
    ckb2.style.display="none";
    ckb3.style.display="none";

    var rd_select = document.querySelectorAll('input[name="rb-categorie"]:checked'); //[0].defaultValue;
    const cb = document.querySelectorAll('input[name="rb-categorie"]');
    console.log(cb[1].checked);

    if (document.getElementById('r1').checked) {
        rate_value = document.getElementById('r1').value;
      }

    var check_box_orice = document.getElementById("check-box-orice");
    var check_box_constructii = document.getElementById("check-box-constructii");
    var check_box_amenajari = document.getElementById("check-box-amenajari");

    console.log(rd_select);
    console.log( check_box_orice);
    console.log( check_box_constructii);
    console.log( check_box_amenajari);

    btn.onclick=function(){
        
        let inp=document.getElementById("inp-denumire");
        let numeProdus = inp.value.toLowerCase();
        inp=document.getElementById("inp-pret");
        //console.log(inp);
        let maxPret = inp.value;
        let sel=document.getElementById("sl-livrare");
        let livrareSel=sel.value;
        let culoriSel=Array.from(document.getElementById("sl-culoare").querySelectorAll("option:checked"),e=>e.value);
        //console.log(culoriSel);
        
        var produse=document.getElementsByClassName("produs");
    
        for (let prod of produse){
            prod.style.display="none";
            let nume= prod.getElementsByClassName("nume")[0].innerText;
            nume=nume.slice(6,).toLowerCase();
            var conditie1;
            if(numeProdus==="")
                conditie1=1;
            else
                conditie1=nume.includes(numeProdus);
            
      
            let pret= parseInt(prod.getElementsByClassName("val-pret")[0].innerHTML)
            var conditie2;
            if(maxPret==0)
                conditie2=1;
            else
                conditie2= pret<=maxPret;

            let livrare= prod.getElementsByClassName("cu_livrare")[0].innerText;
            livrare=livrare.slice(10,).toLowerCase();

            var conditie3;
            if(livrareSel=="toate")
                conditie3=1;             
            else 
                conditie3=(livrare==livrareSel);

            let culoare=prod.getElementsByClassName("culoare")[0].innerText;
            culoare=culoare.slice(8,);
            
            
            var conditie4;
            if(culoriSel.length==0)
                conditie4=1;
            else{
                conditie4=0;
                for(var c in culoriSel)
                {  //console.log(culoriSel[c]);
                    //console.log(culoare);
                    if(culoriSel[c]==culoare)
                    {
                    conditie4=1;
                    break;
                    }
                }
            }
            var conditie5=1;
            console.log(rd_select);
            if(rd_select=="orice")
            {
                let ck1=document.getElementById("ck-orice-materiale-constructii");
                // console.log(ck1);
                let ck2=document.getElementById("ck-orice-izolatii");
                let ck3=document.getElementById("ck-orice-amenajari-interioare");
                let ck4=document.getElementById("ck-orice-sanitare");
                if(ck1.checked && ck2.checked && ck3.checked && ck4.checked)
                    conditie5=1;
                else if(!(ck1.checked || ck2.checked || ck3.checked || ck4.checked))
                    conditie5=1;
                let string="";
                // if(ck1.checked)
                //     string+=ck1;

                // if(ck1.checked)
                //     string+=ck1;
            }

           //console.log(conditie4); 
            let conditieFinala=conditie1 && conditie2 && conditie3 && conditie4 && conditie5;
            if (conditieFinala)
                prod.style.display="block";
         
        }
    }


    function sortArticole(factor){
        
        var produse=document.getElementsByClassName("produs");
        let arrayProduse=Array.from(produse);
        arrayProduse.sort(function(art1,art2){
            let nume1=art1.getElementsByClassName("val-nume")[0].innerHTML;
            let nume2=art2.getElementsByClassName("val-nume")[0].innerHTML;
            return factor*nume1.localeCompare(nume2);
            /*
            let rez=factor*nume1.localeCompare(nume2)
            if (rez==0)
                retrun factor*(pret1-pret2)
            return rez;
            */
        });
        //console.log(arrayProduse); 
        for (let prod of arrayProduse){
            prod.parentNode.appendChild(prod);
        }
    }

    btn=document.getElementById("sortCrescNume");
    btn.onclick=function(){
        sortArticole(1);
    }
    btn=document.getElementById("sortDescrescNume");
    btn.onclick=function(){
        sortArticole(-1);
    }

    btn=document.getElementById("resetare");
    btn.onclick=function(){
        
        var produse=document.getElementsByClassName("produs");
        let sel=document.getElementById("sl-livrare");
        sel.value="toate";
        for (let prod of produse){
            prod.style.display="block";
        }
    }



    window.onkeydown=function(e){
        
       
        if (e.key=="c" && e.altKey){
            e.preventDefault();
            var produse=document.getElementsByClassName("produs");
            sumaArt=0;
            for (let prod of produse){
                sumaArt+=parseInt(prod.getElementsByClassName("val-pret")[0].innerHTML);
            }
            let infoSuma=document.createElement("p");//<p></p>
            infoSuma.innerHTML="Suma: "+sumaArt;//<p>...</p>
            infoSuma.className="info-produse";
            let p=document.getElementById("p-suma")
            p.parentNode.insertBefore(infoSuma,p.nextSibling);
            setTimeout(function(){infoSuma.remove()}, 2000);
        }
    }

});

function getit(){
    var ckb1=document.getElementById("check-box-orice");
    var ckb2=document.getElementById("check-box-constructii");
    var ckb3=document.getElementById("check-box-amenajari");
    ckb1.style.display="block";
    ckb2.style.display="none";
    ckb3.style.display="none";

    var select = document.querySelectorAll('input[name="rb-categorie"]:checked')[0].defaultValue;
    //console.log(select);
   if(select=="orice")
   {
    ckb1.style.display="block";
    ckb2.style.display="none";
    ckb3.style.display="none";
   }
   else if(select=="constructii")
   {
    ckb1.style.display="none";
    ckb2.style.display="block";
    ckb3.style.display="none";
   }
   else if(select=="amenajari")
   {
    ckb1.style.display="none";
    ckb2.style.display="none";
    ckb3.style.display="block";
   }
};


function validate()
{
  var pdcbClass = document.getElementsByClassName("pdcb");
  var idcbClass = document.getElementsByClassName("idcb");
  console.log(this);
    for (var i = 0; i < pdcbClass.length; i++) {
    if (pdcbClass[i].checked == true) {
       document.getElementById("radio1").checked = true;
         document.getElementById("radio2").checked = false;
    }
  }

  for (var i = 0; i < idcbClass.length; i++) {
    if (idcbClass[i].checked == true) {
      document.getElementById("radio1").checked = false;
      document.getElementById("radio2").checked = true;
    }
  }
}