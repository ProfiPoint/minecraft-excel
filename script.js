const categories = document.querySelectorAll('.category');
const underline = document.getElementById('underline');
const slide = document.querySelector('.slide');
const isMobile = /iPhone|iPad|iPod|Android|Mobile/i.test(navigator.userAgent);
var isFullscreen = false;
var wasInHorizontalMode = false;
var firstTimeSpecialCase = true;

// when screen is on fullscreen mode then set the isFullscreen to true if not anymore then set it to false
document.addEventListener('fullscreenchange', () => {
    isFullscreen = document.fullscreenElement !== null;
    console.log(isFullscreen);
});





// Function to update the underline position and width
function updateUnderline() {
    underline.style.width = `${activeCategory.offsetWidth}px`;
    underline.style.left = `${activeCategory.offsetLeft}px`;
}

// Initial setup
let activeCategory = document.getElementById('about-c');
updateUnderline();


// now if F2 is pressed then start listening the input of the what is user tzping and update the activeCategorz live and when user presses enter of F2  or ESC then stop listening and update the activeCategory to the category that was selected by the user

document.addEventListener('keydown', function(e) {
    if (e.key === 'F2') {
        const input = document.createElement('input');
        input.id = "category-input-name";
        input.classList.add('category-input');
        input.value = activeCategory.innerText;
        activeCategory.innerText = '';
        activeCategory.appendChild(input);
        underline.style.transition = 'transform 0.1s ease, width 0.1s ease';
        underline.style.transform = 'scaleX(0)';
        setTimeout(() => {
            updateUnderline();
            underline.style.transform = 'scaleX(1)';
        }, 100);
        input.focus();
        input.addEventListener('keydown', function(e) {
            if (e.key === 'Enter') {
                activeCategory.innerText = input.value;
                presentationTitle.innerText = input.value;
                input.remove();
            } else if (e.key === 'Escape') {
                input.remove();
            }
            underline.style.transition = 'transform 0.1s ease, width 0.1s ease';
            underline.style.transform = 'scaleX(0)';
            setTimeout(() => {
                updateUnderline();
                underline.style.transform = 'scaleX(1)';
            }, 100);
        });
    }
});

document.addEventListener('click', function(e) {
    const input = document.querySelector('.category-input');
    if (input && !input.contains(e.target)) {
        activeCategory.innerText = input.value;
        presentationTitle.innerText = input.value;
        input.remove();
        underline.style.transition = 'transform 0.1s ease, width 0.1s ease';
        underline.style.transform = 'scaleX(0)';
        setTimeout(() => {
            updateUnderline();
            underline.style.transform = 'scaleX(1)';
        }, 100);
    }
});


categories.forEach(category => {
    category.addEventListener('click', () => {
        // Animation for underline
        underline.style.transition = 'transform 0.1s ease, width 0.1s ease';
        underline.style.transform = 'scaleX(0)';
        setTimeout(() => {
            updateUnderline();
            underline.style.transform = 'scaleX(1)';
        }, 100);

        // Update active category
        activeCategory = category;
    });
});

        

async function recolorSvg(element) {
    const response = await fetch(element.src);
    const text = await response.text();
    const parser = new DOMParser();
    const svgDoc = parser.parseFromString(text, "image/svg+xml");
    const svgElement = svgDoc.querySelector('svg');

    // Iterate through all elements in the SVG
    const elements = svgElement.querySelectorAll('*');
    elements.forEach(elem => {

    //const listOfIds = ['add-new-text','add-new-image','increase-text-size','decrease-text-size','bold-style','italic-style','underline-style','alighn-left','alighn-center','alighn-right','aligh-block','text-color','background-color','outline-color','insert-link','change-image','set-slide-color','copy-style','apply-style','layer-up','layer-down'];
    const dictOfIds = {
        "bold-style": defaultElement["boldVAR"],
        "italic-style": defaultElement["italicVAR"],
        "underline-style": defaultElement["underlineVAR"],
        "alighn-left": defaultElement["textAlignVAR"] === "left" ? true : false,
        "alighn-center": defaultElement["textAlignVAR"] === "center" ? true : false,
        "alighn-right": defaultElement["textAlignVAR"] === "right" ? true : false,
        "aligh-block": defaultElement["textAlignVAR"] === "block" ? true : false,
        "text-color": defaultElement["fontColorVAR"] === "transparent" ? "rgba(0, 0, 0, 0.5)" : defaultElement["fontColorVAR"],
        "background-color": defaultElement["backgroundColorVAR"] === "transparent" ? "rgba(128, 128, 128, 0.5)" : defaultElement["backgroundColorVAR"],
        "outline-color": defaultElement["outlineColorVAR"] === "transparent" ? "rgba(128, 128, 128, 0.5)" : defaultElement["outlineColorVAR"],
        "insert-link": currentElement["linkVAR"] === "" ? "#bbbbbb" : "white",
        "change-image": currentElement["imageSrcVAR"] === "" ? "#bbbbbb" : "white",
        "layer-up": currentElement["layerVAR"] >= slide.querySelectorAll('.input-box').length ? "#bbbbbb" : "white",
        "layer-down": currentElement["layerVAR"] <= 1 ? "#bbbbbb" : "white",
        "copy-style": SlideData["slides"][slideNow]["generalSlideData"]["copyStyle"],
        "undo": Object.keys(SlideData["slides"][slideNow]["actionHistory"]).length - actionOffset <= 1 ? "#bbbbbb" : "white",
        "redo": actionOffset === 0 ? "#bbbbbb" : "white",
    };

        if (element.id === "text-color" || element.id === "background-color" || element.id === "outline-color" || element.id === "set-slide-color") {
            elem.style.filter = "drop-shadow(0 0 1vh white)";
        }

        if (element.id === "set-slide-color"){
            const fill = elem.getAttribute('fill');
            if (fill === 'black' || fill === '#000' || fill === '#000000' || fill != 'none') {
                elem.setAttribute('fill', SlideData["slides"][slideNow]["generalSlideData"].slideColor);
            } else if (fill == null) {
                elem.setAttribute('fill', SlideData["slides"][slideNow]["generalSlideData"].slideColor);
            }
            return;
        }

        if (element.id === "copy-style"){
            const fill = elem.getAttribute('fill');
            if (fill === 'black' || fill === '#000' || fill === '#000000' || fill != 'none') {
                elem.setAttribute('fill', dictOfIds[element.id] ? '#ffffff' : '#bbbbbb');
                elem.style.filter = "drop-shadow(0 0 1vh white)";
            } else if (fill == null) {
                elem.setAttribute('fill', dictOfIds[element.id] ? '#ffffff' : '#bbbbbb');
                elem.style.filter = "drop-shadow(0 0 1vh white)";
            }
            return;
        }

        if (element.id in dictOfIds) {
            if (dictOfIds[element.id] == true || dictOfIds[element.id] == false){
                const fill = elem.getAttribute('fill');
                
                if (dictOfIds[element.id] == true){
                    
                    elem.style.filter = "drop-shadow(0 0 0.5vh green)";

                    if (fill === 'black' || fill === '#000' || fill === '#000000' || fill != 'none') {
                        elem.setAttribute('fill', '#ffffff');
                    } else if (fill == null) {
                        elem.setAttribute('fill', '#ffffff');
                    }
                } else {
                    if (fill === 'black' || fill === '#000' || fill === '#000000' || fill != 'none') {
                        elem.setAttribute('fill', '#bbbbbb');
                    } else if (fill == null) {
                        elem.setAttribute('fill', '#bbbbbb');
                    }
                } 
            } else {
                const fill = elem.getAttribute('fill');
                if (fill === 'black' || fill === '#000' || fill === '#000000' || fill != 'none') {
                    elem.setAttribute('fill', dictOfIds[element.id]);
                } else if (fill == null) {
                    elem.setAttribute('fill', dictOfIds[element.id]);
                }
            }
        } else {
            const fill = elem.getAttribute('fill');
            if (fill === 'black' || fill === '#000' || fill === '#000000' || fill != 'none') {
                elem.setAttribute('fill', '#ffffff');
            } else if (fill == null) {
                elem.setAttribute('fill', '#ffffff');
            }
        }
    });

    // Convert the modified SVG back to a string
    const serializer = new XMLSerializer();
    const newSvg = serializer.serializeToString(svgElement);

    // Create a data URL and set it as the img's src
    const svg64 = btoa(newSvg);
    const image64 = `data:image/svg+xml;base64,${svg64}`;
    element.src = image64;
}

function recolorAllSvgs() {
    const svgIcons = document.querySelectorAll('.svg-icon');
    svgIcons.forEach(icon => recolorSvg(icon));
}

// Call the function to recolor all SVGs
recolorAllSvgs();

function windowResized() {
    fixTheFullscreenSlide(isMobile && isFullscreen && window.innerWidth < window.innerHeight);
    updateUnderline();

    // now take element id: outline-color get the left corner in pixels on the screen and the width and heigh in px, now take another element id=color-picker-outline and set the left corner to the left corner of the outline-color element and set the width and height to the width and height of the outline-color element

    const outlineColorRect = document.getElementById('outline-color').getBoundingClientRect();
    const colorPickerOutline = document.getElementById('color-picker-outline');

    const backgroundColorRect = document.getElementById('background-color').getBoundingClientRect();
    const colorPickerBackground = document.getElementById('color-picker-background');

    const textColorRect = document.getElementById('text-color').getBoundingClientRect();
    const colorPickerText = document.getElementById('color-picker-text');

    const colorPickerSlide = document.getElementById('color-picker-slide');
    const slideColorRect = document.getElementById('set-slide-color').getBoundingClientRect();

    const Rects = [outlineColorRect, backgroundColorRect, textColorRect, slideColorRect];
    const Pickers = [colorPickerOutline, colorPickerBackground, colorPickerText, colorPickerSlide];

    for (let i = 0; i < Rects.length; i++) {
        Pickers[i].style.left = `${Rects[i].left}px`;
        const topestHeader = document.getElementById('topest-header');
        const editHeader1 = document.getElementById('edit-header-1');
        const topestHeaderHeight = window.getComputedStyle(topestHeader).height;
        const editHeader1Height = window.getComputedStyle(editHeader1).height;
        Pickers[i].style.top = `${Rects[i].top - parseInt(topestHeaderHeight) - parseInt(editHeader1Height)}px`;
        Pickers[i].style.width = `${Rects[i].width}px`;
        Pickers[i].style.height = `${Rects[i].height}px`;
    }

    
    //check if its mobile and isinfullscreen mode and the phone is in horizontal mode then exit the fullscreen mode
    if (isMobile && isFullscreen && window.innerWidth < window.innerHeight) {
        document.exitFullscreen();
        wasInHorizontalMode = true;
    }

    if (isMobile && wasInHorizontalMode && window.innerWidth > window.innerHeight) {
        document.documentElement.requestFullscreen();
        wasInHorizontalMode = false;
    }

}

windowResized();
window.addEventListener('resize', windowResized);

function resizeSidebar(width,windowWidth){
    const dragHandle = document.getElementById('dragHandle');
    const sidebar = document.getElementById('sidebar');
    /*
    sidebar.style.width = `${width}px`;
    dragHandle.style.left = `${width}px`; now instead of px use % calculationgf by using windowWidth */
    sidebar.style.width = `${width/windowWidth*100}%`;	
    dragHandle.style.left = `${width/windowWidth*100}%`;
}

document.addEventListener('DOMContentLoaded', function() {
    const dragHandle = document.getElementById('dragHandle');
    const sidebar = document.getElementById('sidebar');
    const content = document.getElementById('content');
    let isDragging = false;

    dragHandle.addEventListener('mousedown', function(e) {
        isDragging = true;
    });

    document.addEventListener('mousemove', function(e) {
        if (isDragging) {
            const mouseX = e.pageX;
            const sidebarRect = sidebar.getBoundingClientRect();
            const containerRect = document.querySelector('.container').getBoundingClientRect();
            let windowWidth = window.innerWidth;
            const minSidebarWidth = windowWidth * 0.1;
            const maxSidebarWidth = windowWidth * 0.4;
            let newWidth = mouseX - sidebarRect.left;

            if (mouseX < containerRect.width) {
                if (newWidth > minSidebarWidth && newWidth < maxSidebarWidth){
                    resizeSidebar(newWidth,windowWidth);
                } else if (newWidth > maxSidebarWidth){
                    resizeSidebar(maxSidebarWidth,windowWidth);
                } else {
                    resizeSidebar(minSidebarWidth,windowWidth);
                }

            }
        }
    });

    document.addEventListener('mouseup', function(e) {
        isDragging = false;
    });
});