// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.


// idea_bodies = document.querySelectorAll(".idea-body")
// for (let node of idea_bodies) {
//     node.addEventlistener("click", (event) => {
//         node.style.display = "inline"
//     })


document.addEventListener('DOMContentLoaded', (event) => {
    document.querySelectorAll('.plus').forEach((node) =>
          node.addEventListener('click', (event) => {
            if (event.target.parentElement.parentElement.children[1].style.display == "none"){
                event.target.parentElement.parentElement.children[1].style.display = "block"
            }
            else{
                event.target.parentElement.parentElement.children[1].style.display = "none"
            }

            })
    );
  });

