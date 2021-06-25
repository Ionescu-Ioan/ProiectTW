
window.addEventListener("DOMContentLoaded", function()
{
    let tema=localStorage.getItem("tema");
    let icon_tema=localStorage.getItem("icon_tema");
    if(tema=="dark")
    {
        document.body.classList.add("dark");
        document.querySelector("#icon-changer").classList.remove("fa-sun");
        document.querySelector("#icon-changer").classList.add("fa-moon");
    }
        
    document.getElementById("schimbare-tema").onclick=function(){
        document.body.classList.toggle("dark");
        if(document.body.classList.contains("dark")){
            localStorage.setItem("tema", "dark");
            localStorage.setItem("icon_tema", "fa fa-moon");
        }
        else
        {
            localStorage.setItem("tema", "light");
            localStorage.setItem("icon_tema", "fa fa-sun");
        }
        
    }
});
