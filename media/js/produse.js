window.addEventListener("load", function(){

    let btn=document.getElementById("filtrare");

    // var categ_btns=document.getElementsByClassName("buton_categ");
    // for(let categ_btn of categ_btns)
    // {
    //     categ_btn.onclick=function(event){
           
    //         event.preventDefault();
    //         document.querySelector('input[name="rb-categorie"]:checked').checked=false;
    //         document.getElementById(`rd-${this.innerText.toLowerCase()}`).checked=true;
    //         document.getElementById("filtrare").click();
    //     }
    // }

    var art_prod = document.getElementsByClassName("produs");
    for(let i=0; i<art_prod.length; i++)
        {art_prod[i].addEventListener("click", function( event ){
            document.location="/produs/"+this.id.substr(5);
        });}
    var slider = document.getElementById("inp-pret");
    var output = document.getElementById("rez-range");
  
    
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
  

    

    var ckb1=document.getElementById("check-box-orice");
    var ckb2=document.getElementById("check-box-constructii");
    var ckb3=document.getElementById("check-box-amenajari");
    ckb1.style.display="block";
    ckb2.style.display="none";
    ckb3.style.display="none";
    var check_box_orice = document.getElementById("check-box-orice");
    var check_box_constructii = document.getElementById("check-box-constructii");
    var check_box_amenajari = document.getElementById("check-box-amenajari");


    btn.onclick=function(){

        let inp=document.getElementById("inp-denumire");
        let numeProdus = inp.value.toLowerCase();
        let textarea=document.getElementById("textarea").value.trim().split(/[\s\n\t]+/);
       for(let i=0; i<numeProdus.length; i++)
        {
            if(!((numeProdus[i]>='a' && numeProdus[i]<='z') || numeProdus[i]==' '))
            {
                alert("Denumire invalida!");
                return;
            }
        }
        for(let j=0; j<textarea.length; j++)
        {
            let string=textarea[j];
            for(let i=0; i<string.length; i++)
            {
                if(!((string[i]>='a' && string[i]<='z') || string[i]==' '))
                {
                    alert("Materiale componente invalide!");
                    return;
                }
            }
        }

      
      
        inp=document.getElementById("inp-pret");
      
        let maxPret = inp.value;
        let sel=document.getElementById("sl-livrare");
        let livrareSel=sel.value;
        let culoriSel=Array.from(document.getElementById("sl-culoare").querySelectorAll("option:checked"),e=>e.value);
        
        
        var produse=document.getElementsByClassName("produs");
    
        for (let prod of produse){
            prod.style.display="none";
            let nume= prod.getElementsByClassName("nume")[0].innerText;
            nume=nume.slice(6,).toLowerCase();
            var conditie1;
            if(numeProdus==="")
                conditie1=true;
            else
            {
                conditie1=checkWordsWithErrors(nume, numeProdus);
            }
                
            
      
            let pret= parseInt(prod.getElementsByClassName("val-pret")[0].innerHTML)
            var conditie2=false;
            if(maxPret==0)
                conditie2=true;
            else
                conditie2= pret<=maxPret;

            let livrare= prod.getElementsByClassName("cu_livrare")[0].innerText;
            livrare=livrare.slice(10,).toLowerCase();

            var conditie3=false;
            if(livrareSel=="toate")
                conditie3=true;             
            else 
                conditie3=(livrare==livrareSel);

            let culoare=prod.getElementsByClassName("culoare")[0].innerText;
            culoare=culoare.slice(9,);
            
            
            var conditie4=false;
            if(culoriSel.length==0)
                conditie4=true;
            else{
                conditie4=false;
                for(var c in culoriSel)
                {  
                    if(culoriSel[c]==culoare)
                    {
                    conditie4=true;
                    break;
                    }
                }
            }
            var rd_select = document.querySelector('input[name="rb-categorie"]:checked').value;
            // conditie radio btn
            var categ=prod.querySelector(".categorie > .val-categorie").innerText;
            var conditie5=(rd_select=="orice") || (rd_select==categ);
            //conditie checkbox 
            var tip_produs=prod.querySelector(".tip_produs > .val-tip-produs").innerText;
            var conditie6=false;
       
            let ck_id=`ck-${rd_select}-${tip_produs.split(" ").join("-")}`;
            let ck=document.getElementById(ck_id) || {};
            let ck1=document.getElementById(`ck-${rd_select}-materiale-constructii`) || {};
            let ck2=document.getElementById(`ck-${rd_select}-izolatii`) || {};
            let ck3=document.getElementById(`ck-${rd_select}-amenajari-interioare`) || {};
            let ck4=document.getElementById(`ck-${rd_select}-sanitare`) || {};
            
            if(!(ck1.checked || ck2.checked || ck3.checked || ck4.checked) || ck.checked)
                conditie6=true;
           
            
            var conditie7=false;
           
            if(textarea.length<=0)
            {
                conditie7=true;
           
            }
            else
            {
                let materiale=prod.getElementsByClassName("val-materiale-componente")[0].innerText;
                for(let word of textarea)
                {
                    const ok=materiale.includes(word);
                    if(ok)
                    {
                        conditie7=ok;
                    }
                }
            }

            let conditieFinala=conditie1 && conditie2 && conditie3 && conditie4 && conditie5 && conditie6 && conditie7;
            if (conditieFinala)
                prod.style.display="grid";
         
        }
    }


    function sortArticole(factor){
        
        var produse=document.getElementsByClassName("produs");
        let arrayProduse=Array.from(produse);
        arrayProduse.sort(function(art1,art2){
            let pret1=parseFloat(art1.getElementsByClassName("val-pret")[0].innerText.trim());
            let pret2=parseFloat(art2.getElementsByClassName("val-pret")[0].innerText.trim());
            //console.log(art1.getElementsByClassName("val-pret")[0], art1.getElementsByClassName("val-pret")[0].innerText, art1.getElementsByClassName("val-pret")[0].innerText.trim().split(" ")[1], pret1);
            if(pret1==pret2)
            {
                let nume1=art1.getElementsByClassName("val-nume")[0].innerHTML;
                let nume2=art2.getElementsByClassName("val-nume")[0].innerHTML;
                return factor*nume1.localeCompare(nume2);
            }
            return factor*(pret1-pret2);
            /*
            let rez=factor*nume1.localeCompare(nume2)
            if (rez==0)
                retrun factor*(pret1-pret2)
            return rez;
            */
        });
       
        for (let prod of arrayProduse){
            prod.parentNode.appendChild(prod);
        }
    }

    btn=document.getElementById("sortCrescPret");
    btn.onclick=function(){
        sortArticole(1);
    }
    btn=document.getElementById("sortDescrescPret");
    btn.onclick=function(){
        sortArticole(-1);
    }

    btn=document.getElementById("resetare");
    // Return an array of the selected opion values
    // select is an HTML select element
    function getSelectValues(select) {
        var result = [];
        var options = select && select.options;
        var opt;
    
        for (var i=0, iLen=options.length; i<iLen; i++) {
        opt = options[i];
    
        if (opt.selected) {
            result.push(opt.value || opt.text);
        }
        }
        return result;
    }
  
    btn.onclick=function(){
        var cks=document.querySelectorAll('input[name="tip"]:checked');
        var produse=document.getElementsByClassName("produs");
        let sel=document.getElementById("sl-livrare");
        let sel1=document.getElementById("sl-culoare");
        let denumire=document.getElementById("inp-denumire");
        let pret=document.getElementById("inp-pret");
        document.getElementById("textarea").value="";
        document.querySelector('input[name="rb-categorie"]:checked').checked=false;
        document.getElementById("rd-orice").checked=true;
        denumire.value="";
        pret.value="0";
        document.getElementById("rez-range").innerHTML="";
        for(ck of cks)
        {
            ck.checked=false;
        }

        let get=getSelectValues(sel1);

        sel.value="toate";
        sel1.value=[];
        for (let prod of produse){
            prod.style.display="grid";
        }
    }



    document.getElementById("p-suma").onclick=function(e){
        
       
        var produse=document.getElementsByClassName("produs");
        sumaArt=0;
        for (let prod of produse){
            if(prod.style.display!="none")
                sumaArt+=parseInt(prod.getElementsByClassName("val-pret")[0].innerHTML);
        }
        let infoSuma=document.createElement("p");//<p></p>
        infoSuma.innerHTML="Suma: "+sumaArt;//<p>...</p>
        infoSuma.className="info-produse";
        let p=document.getElementById("p-suma")
        p.parentNode.insertBefore(infoSuma,p.nextSibling);
        setTimeout(function(){infoSuma.remove()}, 2000);
        
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

function checkStringWithErrors(actualStr, searchedStr) {
    let maxErrors = 2;
    const diff = searchedStr.length - actualStr.length;

    if (diff < 0 || diff > maxErrors) return false;
    let i = 0;
    for (let j = 0; i < actualStr.length && j < searchedStr.length; i++, j++) {
        const char1 = actualStr[i];
        const char2 = searchedStr[j];
        if (!char1 || !char2) return false;
        if (char1 !== char2) {
            // i--;
            maxErrors--;
        }
        if (maxErrors < 0) return false;
    }
    // if(i != actualStr.length)
    // {
    //     return false;
    // }
    return true;
}

function checkWordsWithErrors(actualWords, searchedWords) {
    const actualWordsArr = actualWords.split(/[\s]+/);
    const index1 = actualWordsArr.indexOf("cu");
    if (index1 > -1) {
        actualWordsArr.splice(index1, 1);
    }
    const index2 = actualWordsArr.indexOf("de");
    if (index2 > -1) {
        actualWordsArr.splice(index2, 1);
    }
    const searchedWordsArr = searchedWords.split(/[\s]+/);
    if (actualWordsArr.length < searchedWordsArr.length) return false;
    let j = 0;
    while (searchedWordsArr[j]) {
        let ok = false;
        for(let i = 0; i < actualWordsArr.length; i++) {
            if (checkStringWithErrors(actualWordsArr[i], searchedWordsArr[j])) {
                ok = true;
                actualWordsArr.splice(i, 1);
                break;
            }
        }
        if (ok) {
            j++;
        } else {
            return false;
        }
    }
    return true;
}
