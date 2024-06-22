const editHeader1 = document.querySelector('#edit-header-1');
const editHeader2 = document.querySelector('#edit-header-2');
const fullscreenWhite = document.querySelector('.fullscreen-white');
const fullscreeBlack = document.querySelector('.fullscreen-black');
const presentationTitle = document.querySelector('.presentation-title');
const createNewPresentation = document.getElementById("create-new-presentation");


var slideWidthSaved = 0;
var canExitPresentation = false;
var defaultBackgroundImage = "";

function wait(ms) {
    return new Promise(resolve => setTimeout(resolve, ms));
}

function presentationMode(state,key){
    if (state){
        slideWidthSaved = document.querySelector('.slide').offsetWidth;
        document.querySelector('.fullscreen-white').style.display = 'block';
        document.querySelector('.fullscreen-black').style.display = 'block';
        // hide slide
        document.querySelector('.slide').style.display = 'none';
        document.querySelector('.sidebar').style.display = 'none';
        //set the screen to fullscreen (like F11)
        if (key !== true){
            document.querySelector('.fullscreen-white').requestFullscreen();
        }
        isFullscreen = true;
        fixTheFullscreenSlide();
        setUrlAtributes();
    } else {
        document.querySelector('.fullscreen-white').style.display = 'none';
        document.querySelector('.fullscreen-black').style.display = 'none';
        // show slide
        document.querySelector('.slide').style.display = 'block';
        document.querySelector('.sidebar').style.display = 'block';
        slideWidthSaved = document.querySelector('.slide').offsetWidth;
        //exit fullscreen
        if (document.fullscreenElement) {
            document.exitFullscreen();
        }
        isFullscreen = false;
        fixTheFullscreenSlide();
        setUrlAtributes();
    }    
}

function fixTheFullscreenSlide(specialMobileCase){
    
    // Set the class fullscreen-white to always be 16:9
    const fullscreenWhite = document.querySelector('.fullscreen-white');
    const aspectRatio = 16 / 9;
    let width, height;


    // Calculate the width and height based on the window inner dimensions
    if (window.innerWidth / window.innerHeight > aspectRatio) {
        height = window.innerHeight;
        width = height * aspectRatio;
    } else {
        width = window.innerWidth;
        height = width / aspectRatio;
    }




    if (specialMobileCase && firstTimeSpecialCase){
        firstTimeSpecialCase = false;
        alert("Please zoom out and scroll down or rotate your phone to see the full slide.");    
    } 
    fullscreenWhite.style.width = `${width}px`;
    fullscreenWhite.style.height = `${height}px`;

    fullscreenWhite.style.left = `${(window.innerWidth - width) / 2}px`;
    fullscreenWhite.style.top = `${(window.innerHeight - height) / 2}px`;
    

    // Set the width and height of fullscreen-white
    

    // for all the input.box.elements set the width and height to the width and height of the fullscreen-white
    const inputBoxes = document.querySelectorAll('.input-box-element');
    //unhide the slide if its hidden
    if (document.querySelector('.slide').style.display === 'none'){
        document.querySelector('.slide').style.display = 'block';
        slideWidthSaved = document.querySelector('.slide').offsetWidth;
        document.querySelector('.slide').style.display = 'none';
    } else {
        slideWidthSaved = document.querySelector('.slide').offsetWidth;
    }

    
    inputBoxes.forEach(box => {
        if (box.closest('.fullscreen-white')) {
            const presentationModeElement = document.querySelector('.fullscreen-white');
            const slideWidth = slide.offsetWidth;
            const windowWidth = window.innerWidth;
            var theSpecialRatio = presentationModeElement.offsetWidth / windowWidth

            // if the window width is the same as the slide width then the ratio is 1
            if (windowWidth === slideWidth){
                theSpecialRatio = 1;
                //console.log("1");
            }
            //console.log(windowWidth, slideWidth, theSpecialRatio);

            box.style.fontSize = (box.originalFontSize / 10) * (presentationModeElement.offsetWidth / slideWidthSaved * (theSpecialRatio)) + "vw";
            /*console.log(
                box.originalFontSize,
                slideWidthSaved ,
                windowWidth,
                windowWidth,
                (box.originalFontSize / 10) * (presentationModeElement.offsetWidth / slideWidth) + "vw",
                (presentationModeElement.offsetWidth / windowWidth)
            );*/
        }
    });   

    // for all the input.box.elements set the width and height to the width and height of the slide
    inputBoxes.forEach(box => {
        if (box.closest('.slide')) {
            const slideWidth = slide.offsetWidth || slideWidthSaved;
            const windowWidth = window.innerWidth;
            box.style.fontSize = (box.originalFontSize / 10) * (slideWidth / windowWidth) + "vw";
           /* console.log(
                box.originalFontSize,
                slideWidthSaved ,
                windowWidth,
                windowWidth,
                (box.originalFontSize / 10) * (slideWidth.offsetWidth / windowWidth) + "vw",
                (slideWidth.offsetWidth / windowWidth),
                slideWidth
            );*/
        }
    });   

    // for all the input.box.elements set the width and height to the width and height of the slide-preview
    inputBoxes.forEach(box => {
        if (box.closest('.slide-preview')) {
            const slidePreviewWidth = box.closest('.slide-preview').offsetWidth;
            const slideWidth = slide.offsetWidth;
            const windowWidth = window.innerWidth;
            box.style.fontSize = (box.originalFontSize / 10) * (slidePreviewWidth / slideWidth) * (slideWidth / windowWidth) + "vw";
            /*console.log(
                box.originalFontSize,
                slideWidthSaved ,
                windowWidth,
                windowWidth,
                (box.originalFontSize / 10) * (slidePreviewWidth / slideWidth) * (slideWidth / windowWidth) + "vw",
                (slidePreviewWidth / slideWidth) * (slideWidth / windowWidth),
                slidePreviewWidth,
                slideWidth
            );*/
        }
    });

}







fullscreeBlack.addEventListener('click', () => {
    presentationMode(false);
    wasInHorizontalMode = false;
});


presentationMode(false);

// if user presses F11 then go to presentation mode
document.addEventListener('keydown', (e) => {
    if (e.key === 'F11'){
        presentationMode(true,true);
    } else if (e.key === 'Escape'){
        presentationMode(false);
    }
});



document.querySelectorAll('#play').forEach(play => {
    play.addEventListener('click', () => {
        presentationMode(true);
    });
});


var isInUserCreatedMode = false;

var actionOffset = 0;

currentElement = {            
    typeVAR: "text",
    linkVAR: "",
    textVAR: "",
    imageSrcVAR: "",
    boldVAR: false,
    underlineVAR: false,
    italicVAR: false,
    fontFamilyVAR: "calibri",
    fontSizeVAR: 20,
    fontColorVAR: "#000000",
    backgroundColorVAR: "transparent",
    outlineColorVAR: "transparent",
    outlineWidthVAR: 2,
    textAlignVAR: "center",
    leftVAR: "40%",
    topVAR: "40%",
    widthVAR: "20%",
    heightVAR: "20%",
    layerVAR: -1
};

defaultElement = {  
    typeVAR: "text",
    linkVAR: null,
    textVAR: null,
    imageSrcVAR: null,
    boldVAR: false,
    underlineVAR: false,
    italicVAR: false,
    fontFamilyVAR: "calibri",
    fontSizeVAR: null,
    fontColorVAR: "#000000",
    backgroundColorVAR: "transparent",
    outlineColorVAR: "transparent",
    outlineWidthVAR: null,
    textAlignVAR: "center",
    leftVAR: null,
    topVAR: null,
    widthVAR: null,
    heightVAR: null,
    layerVAR: null,
};


const webSafeFonts = [
    'Aladin',
    'Aldebara',
    'Almanac Italic Grunge',
    'Alphabet Wave',
    'Amoxan',
    'Animasi Eyes',
    'Annabelle',
    'Arial',
    'Arial Black',
    'Azhitromicin',
    'Baby Cute',
    'Baby Doll',
    'Balotak',
    'Balqis',
    'Beautiful Leaves',
    'Beaver',
    'Belarosa',
    'Belepotan',
    'Black Forest',
    'Black Riders',
    'Blackentina 4f',
    'Bloody',
    'Blowbrush',
    'Blue Ocean',
    'Bluegrass Outline',
    'Boncegro Ff 4f',
    'Booster',
    'Bougenville Flowers',
    'Broken Heart',
    'Bromello',
    'Browie',
    'Bubble Boba',
    'Butterfly',
    'Cakiss',
    'Calibri',
    'Calliope Fun',
    'Cattrine',
    'Ceftriaxon',
    'Charles',
    'Cheerful Year',
    'Chocolate Heart Free',
    'Chocoleta',
    'Christmas',
    'Coffee Break',
    'Coffee Robusta',
    'Comic Sans MS',
    'Cornerstone',
    'Courier New',
    'Crunchy',
    'Cute Love',
    'Cutes',
    'Cutie Star',
    'Debby',
    'Decomart Ff 4f',
    'Delicious Food',
    'Devil Beside You',
    'Diamond',
    'Digital Marketing',
    'Dolce Vita',
    'Donuts',
    'Emerald',
    'Everybody',
    'Explore',
    'Flowers',
    'Fonesia Regular',
    'Fredoka One',
    'Friendly',
    'Funny Kids',
    'Ganguro',
    'Gendis Flower',
    'Georgia',
    'Georgia',
    'Georgios',
    'Glasoor Ff 4f',
    'Golden Pumpkin',
    'Greentea Milkshake',
    'Guerrilla',
    'Gupis',
    'Halloween',
    'Hamurz',
    'Happy Christmas',
    'Happy New Year',
    'Happy Shopping',
    'Happy Weekend',
    'Hello Christmas',
    'Hello Winter',
    'Hellow January',
    'Helltown',
    'Heyro Fun',
    'Hidrocloroquin',
    'Hollster',
    'Honeymoon',
    'Humblle Rought Caps',
    'Hundredth',
    'Impact',
    'Jamoer Rough Free',
    'Jelline',
    'Jhonny Handlettering',
    'Jons',
    'Judas',
    'Just Friend',
    'Kaneda',
    'Kindergarten',
    'Krriiukk',
    'Leaf',
    'Lets Go To School',
    'Lighting',
    'Liquide',
    'Love Bubbles',
    'Lovely',
    'Lucida Console',
    'Lucida Sans Unicode',
    'Lumber',
    'Luna',
    'Mandalaclipart-regular',
    'Manopo',
    'Memoriam',
    'Mennuah',
    'Metal Blackletter',
    'Metal Curve',
    'Metalblackletter',
    'Methilprednisolon',
    'Michy',
    'Miracle Of Christmas',
    'Mom Cooking',
    'Monolog',
    'Monopoly Regular',
    'Moo Milky',
    'Mouw',
    'My Princess',
    'Naturally',
    'Neonclipper Normal',
    'Nightamore Brush Free Font',
    'Nikoleta',
    'Noble Notes',
    'North Star',
    'Nothing',
    'Octomorf',
    'One More',
    'One Stripe',
    'Oneday',
    'Outline',
    'Palatino Linotype',
    'Photography',
    'Pikachu',
    'Pillow',
    'Playground',
    'Polipuli',
    'Pompom',
    'Pow Kids',
    'Princess',
    'Purple',
    'Puzzle',
    'Qiwqiw',
    'Quartz',
    'Quest',
    'Quickline',
    'Quito',
    'Remember',
    'Retro Sans',
    'Retro Slab Serif',
    'Richeese',
    'Rolling Door',
    'Ruby Ruby',
    'Ruffle Beauty',
    'Sand',
    'Sandra',
    'Sansan',
    'Sansullin',
    'Santa Claus',
    'Saranghae',
    'Sarapan',
    'Say Hello',
    'Scarlove',
    'Sequel Regular',
    'Serifiqo 4f Free Capitals',
    'Shiro',
    'Shizuka',
    'Sky Face',
    'Solaria',
    'Solatip',
    'Solmet Brush',
    'Squaress',
    'Srengngee',
    'Start-up',
    'Stay Story',
    'Stricker',
    'Stripe Calm',
    'Sueltaa Sueltaa',
    'Sunshine',
    'Swistblnk Moabhoers',
    'Tahoma',
    'Taro Flowers',
    'Tessellate Regular',
    'Thai Tea',
    'The Goldsmith Vintage',
    'Times New Roman',
    'Tombow',
    'Travelling',
    'Trebuchet MS',
    'Tremor',
    'Unicorn Beautifull',
    'Upnormal',
    'Verdana',
    'Victorian Parlor Vintage Alternate_free',
    'Wedding',
    'Wedding Knick Knacks',
    'Welcome Santa',
    'Wild',
    'Willy',
    'Wings_of_darkness',
    'Winner',
    'Winter Soraya',
    'Young Heart',
];

allElements = {};

styleCopied = [];

var currentDate = new Date();
var year = currentDate.getFullYear();
var month = String(currentDate.getMonth() + 1).padStart(2, '0');
var day = String(currentDate.getDate()).padStart(2, '0');
var hours = String(currentDate.getHours()).padStart(2, '0');
var minutes = String(currentDate.getMinutes()).padStart(2, '0');
var seconds = String(currentDate.getSeconds()).padStart(2, '0');

var formattedDate = `${year}-${month}-${day}-${hours}-${minutes}-${seconds}`;

let SlideData = {
    "slides": [{
        "allElements": {},
        "generalSlideData": {},
        "actionHistory": []
    }],
    "metaData": {
        "title": "Presentation1",
        "description": "",
        "author": userName,
        "authorUpdated": userName,
        "dateCreated": formattedDate,
        "dateModified": formattedDate,
        "defaultBgImage": ""
    }
};


let UserMadePresentation = [];
var slideNow = 1;

function fixActionLog() {
    for (let i = SlideData["slides"][slideNow]["actionHistory"].length - 1; i > 0; i--) {
        if (isEqual(SlideData["slides"][slideNow]["actionHistory"][i], SlideData["slides"][slideNow]["actionHistory"][i - 1])) {
            SlideData["slides"][slideNow]["actionHistory"].splice(i, 1);
        }
    }
}



function isEqual(obj1, obj2) {
    //console.log(JSON.stringify(obj1) , JSON.stringify(obj2));
    return JSON.stringify(obj1) === JSON.stringify(obj2);
}

function switchToolbarIcons(id){
    // if id = 1 then show element with class edit-header-1 and hide element with class edit-header-2; if id = 2 then show element with class edit-header-2 and hide element with class edit-header-1
    
    if (id === 1){
        editHeader1.style.display = 'block';
        editHeader2.style.display = 'none';
    } else {
        editHeader1.style.display = 'none';
        editHeader2.style.display = 'block';
    } 
}

document.addEventListener('DOMContentLoaded', () => {
    function fullScreenWhiteClicked(state){
        //console.log(slideNow);
        if (state){
            if (canExitPresentation){
                //console.log("awfgwa");
                canExitPresentation = false;
                slideNow = 1;
                presentationMode(false);
                UpdateSlidePreview();
            } else {
                if (slideNow -1 < SlideData["slides"].length){
                    slideNow++;
                    if (slideNow  < SlideData["slides"].length){
                        UpdateSlidePreview();
                        canExitPresentation = false;
                    } else if (slideNow -1 < SlideData["slides"].length){
                        //UpdateSlidePreview();
                        fullscreenWhite.innerHTML = "";
                        fullscreenWhite.style.backgroundColor = "#111111";
                        fullscreenWhite.textContent = "End of slide show, click to exit.";
                        fullscreenWhite.style.textAlign = "center";
                        fullscreenWhite.style.verticalAlign = "middle";
                        fullscreenWhite.style.fontSize = "20px";
                        fullscreenWhite.style.color = "#ffffff";
                        canExitPresentation = true;
                    }
                    //console.log(slideNow, SlideData["slides"].length);
                }
            }
        } else {
            //console.log("awfagw");
            if (slideNow > 1){
                slideNow--;

                UpdateSlidePreview();
                canExitPresentation = false;
            }
        }
        
    }

    fullscreenWhite.addEventListener('click', (e) => {
        const slideWidth = fullscreenWhite.offsetWidth;
        const clickX = e.clientX - fullscreenWhite.getBoundingClientRect().left;

        if (clickX <= (slideWidth * 0.3) && isMobile){ 
            fullScreenWhiteClicked(false);
        } else {
            fullScreenWhiteClicked(true);
        }
    });

    document.addEventListener('keydown', (e) => {
        if (isFullscreen){
            if (e.key === 'ArrowRight' || e.key === " "){
                fullScreenWhiteClicked(true);
            } else if (e.key === 'ArrowLeft'){
                fullScreenWhiteClicked(false);
            }
        }
    });

    document.addEventListener('wheel', (e) => {
        if (isFullscreen){
            if (e.deltaY > 0){
                fullScreenWhiteClicked(true);
            } else if (e.deltaY < 0){
                fullScreenWhiteClicked(false);
            }
        }
    });

    function UpdateSlidePreview(){
        var slidePreview = document.querySelectorAll('.slide-preview')[slideNow-1];

        var elements = slidePreview.querySelectorAll('.input-box');
        elements.forEach(element => {
            element.remove();
        });

        slidePreview.innerHTML = "";
        fullscreenWhite.innerHTML = "";

        for (var [key, value] of Object.entries(SlideData["slides"][slideNow]["allElements"])) {
            for (i = 1; i < Object.entries(SlideData["slides"][slideNow]["allElements"]).length+1; i++){
                if (value.layerVAR === i){
                    valueNew = {}
    
                    for (var [key2, value2] of Object.entries(value)) {
                        //console.log(value2);
                        valueNew[key2.replace("VAR","")] = value2;
                    }
    
                    //console.log(valueNew);
                    createNewElement(valueNew, slidePreview);
                    createNewElement(valueNew, null, fullscreenWhite);
                }
            }
        }


        //set the slide color to fullscreen white
        fullscreenWhite.style.backgroundColor = SlideData["slides"][slideNow]["generalSlideData"].slideColor;


    }

    function ActionMade(){
        for (i = 0; i < actionOffset; i++){
            SlideData["slides"][slideNow]["actionHistory"].pop();
        }
        actionOffset = 0;
    
        const previousData = SlideData["slides"][slideNow]["actionHistory"][SlideData["slides"][slideNow]["actionHistory"].length - 2];
    
        newElemenets = {};
        newGeneralSlideData = {};
    
        for (const [key, value] of Object.entries(SlideData["slides"][slideNow]["allElements"])) {
            newElemenets[key] = {...value};
        }
    
        for (const [key, value] of Object.entries(SlideData["slides"][slideNow]["generalSlideData"])) {
            newGeneralSlideData[key] = {...value};
        }
    
        SlideData["slides"][slideNow]["actionHistory"].push({allElements: newElemenets, generalSlideData: newGeneralSlideData});
    
        fixActionLog();
        UpdateSlidePreview();

        recolorSvg(undo);
        recolorSvg(redo);
    }

    var canOpenLinks = false;
    var inputFocused = false;

    const blurBackground = document.querySelector('.blur-background');
    const slide = document.querySelector('.slide');
    const slideContainer = document.querySelector('.slide-container');
    const sidebar = document.querySelector('#sidebar');
    const slidePreviewContainer = document.querySelector('.slide-preview-container');
    const slidePreviewText = document.querySelector('.slide-preview-text');
    const usernameText = document.querySelector('.username');
    var  slides = document.querySelectorAll('.slide-preview');
    const profiLogo = document.querySelector('.logo');

    const addNewTextButton = document.querySelector('#add-new-text');
    const addNewImageButton = document.querySelector('#add-new-image');
    const fontSizeInput = document.querySelector('#font-size-input');
    const fontStyleInput = document.querySelector('#font-style-input');
    const increaseTextSize = document.querySelector('#increase-text-size');
    const decreaseTextSize = document.querySelector('#decrease-text-size');
    const boldStyle = document.querySelector('#bold-style');
    const italicStyle = document.querySelector('#italic-style');
    const underlineStyle = document.querySelector('#underline-style');
    const alignLeft = document.querySelector('#alighn-left');
    const alignCenter = document.querySelector('#alighn-center');
    const alignRight = document.querySelector('#alighn-right');
    const alignBlock = document.querySelector('#aligh-block');
    const textColor = document.querySelector('#text-color');
    const backgroundColor = document.querySelector('#background-color');
    const outlineColor = document.querySelector('#outline-color');
    const outlineSizeInput = document.querySelector('#outline-size-input');
    const insertLink = document.querySelector('#insert-link');
    const changeImage = document.querySelector('#change-image');
    const setSlideColor = document.querySelector('#set-slide-color');
    const setBackgroundImage = document.querySelector('#set-background-image');
    const copyStyle = document.querySelector('#copy-style');
    const applyStyle = document.querySelector('#apply-style');
    const posXInput = document.querySelector('#pos-x-input');
    const posYInput = document.querySelector('#pos-y-input');
    const sizeXInput = document.querySelector('#size-x-input');
    const sizeYInput = document.querySelector('#size-y-input');
    const layerUp = document.querySelector('#layer-up');
    const layerDown = document.querySelector('#layer-down');
    const undo = document.querySelector('#undo');
    const redo = document.querySelector('#redo');

    const newSlideButton = document.querySelector('#new-slide');
    const deleteSlideButton = document.querySelector('#delete-slide');

    let selectedBox = null;

    usernameText.textContent = userName;
    if (userCanLogIn){
        usernameText.textContent = "Login (" + userName + ")";
    }

    function createNewSlide(){
        slides = document.querySelectorAll('.slide-preview');
        const slidePreviews = document.querySelectorAll('.slide-preview-container');
        const slidePreviewContainer = document.createElement('div');
        slidePreviewContainer.className = 'slide-preview-container';
        const slidePreviewText = document.createElement('div');
        slidePreviewText.className = 'slide-preview-text constant-size-text';
        slidePreviewText.textContent = slides.length + 1;
        const slidePreview = document.createElement('div');
        slidePreview.className = 'slide-preview';
        slidePreviewContainer.appendChild(slidePreviewText);
        slidePreviewContainer.appendChild(slidePreview);
        sidebar.appendChild(slidePreviewContainer);
        slides = document.querySelectorAll('.slide-preview');
        console.log(SlideData);
        SlideData["slides"].push({"allElements":{},"generalSlideData":generalSlideData = {slideColor: "#ffffff", slideBackgroundImage: defaultBackgroundImage || "./assets/bg.jpg", copyStyle: false, slideNumber: 1, slideWidth: 1920, slideHeight: 1080},"actionHistory":[]})
        const slideNumber = slides.length;
        slidePreview.addEventListener('click', () => {
            slides = document.querySelectorAll('.slide-preview');
            slides.forEach(slide => {
                slide.removeAttribute('id');
                slide.setAttribute('id', 'slide-preview');
            });
            //const slideNumber = parseInt(slide.parentElement.querySelector('.slide-preview-text').textContent);
            
            slideChange(slide, slideNumber, slidePreview);
        });
        slideChange(slide, slideNumber, slidePreview);
        UpdateSlidePreview();
    }

    newSlideButton.addEventListener('click', () => {
        createNewSlide();
    });

    createNewSlide();
  
    function slideChange(slide, slideNumber, slidePreview){
        slides = document.querySelectorAll('.slide-preview');
        slides.forEach(slide => {
            slide.removeAttribute('id');
            slide.setAttribute('id', 'slide-preview');
        });

        slidePreview.setAttribute('id', 'slide-preview-selected');

        slideNow = slideNumber;

        // now remove all children elements of slide use querySelectorAll and not slide.innerHTML = "" because it will remove all event listeners
        var elements = document.querySelectorAll('.input-box');
        elements.forEach(element => {
            if (element.closest('.slide') === slide) {
            element.remove();
            }
        });

        for (var [key, value] of Object.entries(SlideData["slides"][slideNow]["allElements"])) {
            for (i = 1; i < Object.entries(SlideData["slides"][slideNow]["allElements"]).length+1; i++){
                if (value.layerVAR === i){
                    valueNew = {}
    
                    for (var [key2, value2] of Object.entries(value)) {
                        //console.log(value2);
                        valueNew[key2.replace("VAR","")] = value2;
                    }

                    createNewElement(valueNew);
                }
            }
        }

        recolorSvg(undo);
        recolorSvg(redo);

        if (selectedBox){
            deselectBox();
        }

        UpdateSlidePreview();
        if (SlideData["slides"][slideNow]["generalSlideData"].slideBackgroundImage){
            blurBackground.style.backgroundImage = `url(${SlideData["slides"][slideNow]["generalSlideData"].slideBackgroundImage})`;
        }
        setUrlAtributes();
    }





    

    undo.addEventListener('click', () => {
        //console.log(841651, SlideData["slides"][slideNow]["actionHistory"].length, actionOffset);
        if (SlideData["slides"][slideNow]["actionHistory"].length > 1){
            actionOffset++;
            const previousData = SlideData["slides"][slideNow]["actionHistory"][SlideData["slides"][slideNow]["actionHistory"].length - 1 - actionOffset];
            if (previousData == undefined){
                UpdateSlidePreview();
                recolorSvg(undo);
                recolorSvg(redo);
                return;
            }
            SlideData["slides"][slideNow]["allElements"] = previousData.allElements;
            SlideData["slides"][slideNow]["generalSlideData"]  = previousData.generalSlideData;
            slide.innerHTML = "";
            for (var [key, value] of Object.entries(SlideData["slides"][slideNow]["allElements"])) {
                for (i = 1; i < Object.entries(SlideData["slides"][slideNow]["allElements"]).length+1; i++){
                    if (value.layerVAR === i){
                        valueNew = {}

                        for (var [key2, value2] of Object.entries(value)) {
                            //console.log(value2);
                            valueNew[key2.replace("VAR","")] = value2;
                        }

                        //console.log(valueNew);
                        createNewElement(valueNew);
                    }
                }
            }
            result = "";
            for (var [key, value] of Object.entries(SlideData["slides"][slideNow]["generalSlideData"] .slideColor)) {
                result += value;
            }
            
            slide.style.backgroundColor = result;
        }
        UpdateSlidePreview();
        recolorSvg(undo);
        recolorSvg(redo);
    });

    redo.addEventListener('click', () => {
        //console.log(841651, SlideData["slides"][slideNow]["actionHistory"].length, actionOffset);
        if (actionOffset > 0){
            actionOffset--;
            const previousData = SlideData["slides"][slideNow]["actionHistory"][SlideData["slides"][slideNow]["actionHistory"].length - 1 - actionOffset];
            SlideData["slides"][slideNow]["allElements"] = previousData.allElements;
            SlideData["slides"][slideNow]["generalSlideData"]  = previousData.generalSlideData;
            slide.innerHTML = "";
            //console.log(26165651);
            for (var [key, value] of Object.entries(SlideData["slides"][slideNow]["allElements"])) {
                for (i = 1; i < Object.entries(SlideData["slides"][slideNow]["allElements"]).length+1; i++){
                    if (value.layerVAR === i){
                        valueNew = {}

                        for (var [key2, value2] of Object.entries(value)) {
                            //console.log(value2);
                            valueNew[key2.replace("VAR","")] = value2;
                        }

                        //console.log(valueNew);
                        createNewElement(valueNew);
                    }
                }
            }
            slide.style.backgroundColor = SlideData["slides"][slideNow]["generalSlideData"] .slideColor;
        }
        UpdateSlidePreview();
        recolorSvg(undo);
        recolorSvg(redo);
    });

    















    //if user holds ctrl key then he can open links otherwise not
    document.addEventListener('keydown', (e) => {
        if (e.ctrlKey){
            canOpenLinks = true;
        }
    });

    document.addEventListener('keyup', (e) => {
        canOpenLinks = false;
    });  

    switchToolbarIcons(1)

    function ApplyStyle(inputBox, input, {type, left, top, width, height, text, fontSize, fontColor, backgroundColor, outlineColor, outlineWidth, textAlign, fontFamily, bold, underline, italic, imageSrc, link, layer}, slidePreview, presentationModeElement){
        var elementDATA = SlideData["slides"][slideNow]["allElements"][inputBox.id];
        
        inputBox.style.left = left;
        inputBox.style.top = top
        inputBox.style.width = width;
        inputBox.style.height = height;

        if (text != "" && text != null && text != undefined && text != "undefined"){
            input.value = text;
            elementDATA.textVAR = text;
        } else if (type === "text"){
            input.value = 'Press space to edit text‎';
            elementDATA.textVAR = 'Press space to edit text‎';
        }
       

        input.style.fontSize = fontSize / 10 + "vw";
        input.style.color = fontColor;
        input.style.backgroundColor = backgroundColor;

        input.style.outlineColor = outlineColor;
        input.style.outlineWidth = outlineWidth / 10 + "vw";

        if (outlineColor || (outlineWidth || outlineWidth === 0)){
            if (outlineColor && (outlineWidth || outlineWidth === 0)){
                input.style.border = `${outlineWidth / 10}vw solid ${outlineColor}`;
            } else if (outlineColor){
                input.style.border = `2.5vw solid ${outlineColor}`;
            } else if ((outlineWidth || outlineWidth === 0)){
                input.style.border = `2.5vw solid #ffffff`;
            }
        }

        var textAlign = textAlign || "center";

        input.style.textAlign = textAlign.replace("block", "justify"); // left, center, right, block (justify)

        if (fontFamily != "" && fontFamily != null && fontFamily != undefined && fontFamily != "undefined"){
            input.style.fontFamily = fontFamily;
        }

        if (bold){
            input.style.fontWeight = "bold";
        }

        if (underline){
            input.style.textDecoration = "underline";
        }

        if (italic){
            input.style.fontStyle = "italic";
        }

        if (imageSrc != "" && imageSrc != null && imageSrc != undefined && imageSrc != "undefined"){ 
            input.style.backgroundImage = `url(${imageSrc})`;
        }

        if (link != "" && link != null && link != undefined && link != "undefined"){
        }

        if (presentationModeElement || slidePreview){
            return;
        } else {
            //.log(26165651);
            if (link != "" && link != null && link != undefined && link != "undefined" && canOpenLinks){
                input.addEventListener('mouseover', () => {
                    input.style.cursor = "pointer";
                });
            }
            input.addEventListener('click', () => {
                //console.log(131131131,link);
                if (link != "" && link != null && link != undefined && link != "undefined" && canOpenLinks){
                    window.open(link, '_blank');
                } else {
                    //fullScreenWhiteClicked();
                }
            });
        }
    }

    

    function createNewElement({type, left, top, width, height, text, fontSize, fontColor, backgroundColor, outlineColor, outlineWidth, textAlign, fontFamily, bold, underline, italic, imageSrc, link, layer, id}, slidePreview, presentationModeElement) {
        var elementDATA = {
            typeVAR: type || "text",
            linkVAR: link || "",
            textVAR: text || "",
            imageSrcVAR: imageSrc || "",
            boldVAR: bold || false,
            underlineVAR: underline || false,
            italicVAR: italic || false,
            fontFamilyVAR: fontFamily || "Calibri",
            fontSizeVAR: fontSize ||20,
            fontColorVAR: fontColor || "#000000",
            backgroundColorVAR: backgroundColor ||"transparent",
            outlineColorVAR: outlineColor ||"transparent",
            outlineWidthVAR: outlineWidth || 0,
            textAlignVAR: textAlign ||"center",
            leftVAR: left ||"40%",
            topVAR: top ||"40%",
            widthVAR: width ||"20%",
            heightVAR: height ||"20%",
            layerVAR: layer || 1,
            idVAR: id || Math.floor(Math.random() * 0xffffffffffffffff).toString(16),
        }

        console.log(outlineWidth);

        const inputBox = document.createElement('div');
        inputBox.className = 'input-box';
        inputBox.id = elementDATA["idVAR"];

        const input = document.createElement('input');
        input.id = elementDATA["idVAR"]+Math.floor(Math.random() * 0xffffffffffffffff).toString(16);
        input.className = 'input-box-element';
        input.classList.add('constant-size-text');
        input.type = 'text';
        input.style.backgroundSize = '100% 100%';  // This will stretch the image to fit the input box
        input.style.backgroundPosition = 'center';
        input.style.backgroundRepeat = 'no-repeat';

        SlideData["slides"][slideNow]["allElements"][inputBox.id] = elementDATA;
        currentElement = elementDATA;

        ApplyStyle(inputBox, input, {type, left, top, width, height, text, fontSize, fontColor, backgroundColor, outlineColor, outlineWidth, textAlign, fontFamily, bold, underline, italic, imageSrc, link, layer}, slidePreview, presentationModeElement); 

        inputBox.appendChild(input);

        input.originalFontSize = fontSize;

        if (slidePreview){
            input.readOnly = true;
            input.contentEditable = 'false';
            const slidePreviewWidth = slidePreview.offsetWidth;
            const slideWidth = slide.offsetWidth;
            const windowWidth = window.innerWidth;
            input.style.fontSize = (fontSize / 10) * (slidePreviewWidth / slideWidth) * (slideWidth / windowWidth) + "vw";

            slidePreview.appendChild(inputBox);
        } else if (presentationModeElement){
            input.readOnly = true;
            input.contentEditable = 'false';
            const presentationModeElementWidth = document.querySelector('.fullscreen-white').offsetWidth;
            const slideWidth = slide.offsetWidth;
            input.style.fontSize = (fontSize / 10) * (presentationModeElementWidth / slideWidth) + "vw";

            presentationModeElement.appendChild(inputBox);

            
            if (link != "" && link != null && link != undefined && link != "undefined"){
                input.addEventListener('mouseover', () => {
                    input.style.cursor = "pointer";
                });
            }
            input.addEventListener('click', (e) => {
                if (link != "" && link != null && link != undefined && link != "undefined"){
                    window.open(link, '_blank');
                } else {
                    const slideWidth = fullscreenWhite.offsetWidth;
                    const clickX = e.clientX - fullscreenWhite.getBoundingClientRect().left;
                    if (clickX <= (slideWidth * 0.3) && isMobile){ 
                        fullScreenWhiteClicked(false);
                    } else {
                        fullScreenWhiteClicked(true);
                    }
                }
            });
        } else {
            input.type = 'text';
            input.contentEditable = 'true';

            
    
    
            input.addEventListener('click', () => {
                if (canOpenLinks && elementDATA.linkVAR != "" && elementDATA.linkVAR != null && elementDATA.linkVAR != undefined && elementDATA.linkVAR != "undefined"){
                    window.open(elementDATA.linkVAR, '_blank');
                }
            });
     
            addResizeHandles(inputBox);

            slide.appendChild(inputBox);
            updateTheGui(inputBox,SlideData["slides"][slideNow]["allElements"][inputBox.id],false);

            selectBox(inputBox);
    
            inputBox.addEventListener('click', (e) => {
                if (inputFocused){
                    inputFocused = false;
                } else {
                    e.stopPropagation();
                    selectBox(inputBox);
                    recolorSvg(layerUp);
                    recolorSvg(layerDown);
                    //currentElement = elementDATA;
                    currentElement = SlideData["slides"][slideNow]["allElements"][selectedBox.id];
                }
            });
    
            document.addEventListener('keydown', (e) => {
                if (e.key === ' ' && selectedBox === inputBox) {
                    if (input.value === 'Press space to edit text‎') {
                        e.preventDefault();
                        input.value = '';
                        elementDATA.textVAR = '';
                        currentElement.textVAR = '';
                    }
                    input.focus();
                }
            });
    
            input.addEventListener('focusout', () => {
                if (input.value === '') {
                    input.value = 'Press space to edit text‎';
                    elementDATA.textVAR = 'Press space to edit text‎';
                    currentElement.textVAR = 'Press space to edit text‎';
                }
                elementDATA.textVAR = input.value;
                currentElement.textVAR = input.value;
                UpdateSlidePreview();
            });
        
            //if user presses DELETE key then delete the selected box if its selected
            document.addEventListener('keydown', (e) => {
                if (e.key === 'Delete' && selectedBox === inputBox && inputFocused === false) {
                    deselectBox();
                    const elementsToRemove = document.querySelectorAll(`.input-box[id="${inputBox.id}"]`);
                    elementsToRemove.forEach(element => element.remove());
                    delete SlideData["slides"][slideNow]["allElements"][inputBox.id];
                }
            });
    
            recolorSvg(layerUp);
            recolorSvg(layerDown);
    
            updateLayerIndexes();
        }
    }

    
    
    // Update input box position and size on window resize
    

    addNewTextButton.addEventListener('click', () => {
        //createNewElement("text");
        
        //createNewElement(type, left, top, width, height, text, fontSize, fontColor, backgroundColor, outlineColor, outlineWidth, textAlign, fontFamily, bold, underline, italic, imageSrc, link)
        //createNewElement("text", "40%", "40%", "20%", "20%", "", 20, "#000000", "#ffffff", "#ffffff", 2.5, "center", "Comic Sans MS", true, true, true, "./assets/af.png", "profipoint.pro")
        var data =  {
            type: "text",
            left: "40%",
            top: "40%",
            width: "30%",
            height: "30%",
            text: "",
            fontSize: 20,
            fontColor: "#000000",
            backgroundColor: "transparent",
            outlineColor: "transparent",
            outlineWidth: 2,
            textAlign: "center",
            fontFamily: "Calibri",
        }

        for (const [key, value] of Object.entries(defaultElement)) {
            if (value != null){
                data[key.replace("VAR","")] = value;
            }
        }

        createNewElement(data);  
        ActionMade();
    });

    function addNewImage(img){
        //get image aspected ratio and then create the image element with the same aspect ratio

        const imgElement = new Image();
        imgElement.src = img;

        imgElement.onload = () => {
            // now add the image to the slide, where the image will be in the center of the slide and make sure to make sure that the both width and height are at least 30% but when width is more than 1920px or height more than 720% tahn make the width/height 100% and the other based on the aspect ration but none of the width/height must be NO larger than 100%
            const imgWidth = imgElement.width / 16;
            const imgHeight = imgElement.height / 9;

            const aspectRatio = imgWidth / imgHeight;
            let width = 0;
            let height = 0;

            if (imgWidth < imgHeight){
                height = 50;
                width = 50 * aspectRatio;
            } else {
                width = 50;
                height = 50 * aspectRatio;
            }            

            var left = (100 - width) / 2 + "%";
            var top = (100 - height) / 2 + "%";

            height = height + "%";
            width = width + "%";

            var data = {
                type: "image",
                left: left,
                top: top,
                width: width,
                height: height,
                text: "",
                fontSize: 20,
                fontColor: "#000000",
                backgroundColor: "transparent",
                outlineColor: "transparent",
                outlineWidth: 2,
                textAlign: "center",
                fontFamily: "Calibri",
                imageSrc: img
            }

            for (const [key, value] of Object.entries(defaultElement)) {
                if (value != null && key != "imageSrcVAR" && key != "typeVAR"){
                    console.log(key.replace("VAR",""), value);
                    data[key.replace("VAR","")] = value;
                }
            }

            createNewElement(data);
            ActionMade();
        };
    }

    addNewImageButton.addEventListener('click', () => {
       //open like that :alert("Please enter the URL of the image you want to add");
         //then add it to the createNewElement function

        var img = prompt("Please enter the URL of the image you want to add", "https://");
        if (img != null && img != "" && img != "https://") {
            addNewImage(img);
        }
    });

    slide.addEventListener('click', (e) => {
        deselectBox();
    });

    slideContainer.addEventListener('click', (e) => {
        if (inputFocused){
            inputFocused = false;
        } else {
            deselectBox();
        }
    });

    function selectBox(box) {
        if (selectedBox) {
            deselectBox(box);
        }

        // set the selected box width and height to the actual width and height of the box (use percentage instead of px)
        const boxStyle = window.getComputedStyle(box);
        const rect = slide.getBoundingClientRect();
        const widthSlidePx = rect.right - rect.left;
        const heightSlidePx = rect.bottom - rect.top;
        box.style.width = parseInt(boxStyle.width) / widthSlidePx * 100 + '%';
        box.style.height = parseInt(boxStyle.height) / heightSlidePx * 100 + '%';



        selectedBox = box;
        box.classList.add('selected-box-edit');
        const resizeHandles = document.querySelectorAll('.resize-handle');
        if (resizeHandles.length === 0) {
            addResizeHandles(box);
            updateTheGui(box,SlideData["slides"][slideNow]["allElements"][box.id],false);
        }

        recolorSvg(insertLink);
    }

    function deselectBox(box) {
        if (selectedBox) {
            selectedBox.classList.remove('selected-box-edit');
            selectedBox = null;
            const resizeHandles = document.querySelectorAll('.resize-handle');
            resizeHandles.forEach(handle => handle.remove());
        }
    }

    function addResizeHandles(box) {
        const positions = ['top-left', 'top-middle', 'top-right', 'middle-left', 'middle-right', 'bottom-left', 'bottom-middle', 'bottom-right'];
        positions.forEach(pos => {
            const handle = document.createElement('div');
            handle.className = `resize-handle ${pos}`;
            box.appendChild(handle);

            handle.addEventListener('mousedown', (e) => {
                if (selectedBox !== box){
                    selectBox(box);
                }
                e.stopPropagation();
                startResize(e, box, pos);
            });
        });

        box.addEventListener('mousedown', (e) => {
            e.stopPropagation();
            startMove(e, box);
        });
    }

    function startResize(e, box, handlePos) {
        e.preventDefault();

        document.documentElement.addEventListener('mousemove', doResize);
        document.documentElement.addEventListener('mouseup', stopResize);

        const rect = slide.getBoundingClientRect();
        const boxStyle = window.getComputedStyle(box);

        const topSlide = rect.top * 100 / window.innerHeight;
        const leftSlide = rect.left * 100 / window.innerWidth;
        const rightSlide = rect.right * 100 / window.innerWidth;
        const bottomSlide = rect.bottom * 100 / window.innerHeight;

        const widthSlidePx = rect.right - rect.left;
        const heightSlidePx = rect.bottom - rect.top;

        const mouseX = e.clientX * 100 / window.innerWidth;
        const mouseY = e.clientY * 100 / window.innerHeight;

        const startingX = (mouseX - leftSlide) / (rightSlide - leftSlide) * 100;
        const startingY = (mouseY - topSlide) / (bottomSlide - topSlide) * 100;

        const startingXwidth = parseInt(boxStyle.width) / widthSlidePx * 100;
        const startingYheight = parseInt(boxStyle.height) / heightSlidePx * 100;

        function doResize(e) {
            var currentX = ((e.clientX * 100 / window.innerWidth) - leftSlide) / (rightSlide - leftSlide) * 100;
            var currentY = ((e.clientY * 100 / window.innerHeight) - topSlide) / (bottomSlide - topSlide) * 100;
            if (handlePos.includes('right')) {
                box.style.width = startingXwidth + (currentX - startingX) + '%';
            } else if (handlePos.includes('left')) {
                box.style.width = (startingXwidth - (currentX - startingX)) + '%';
                box.style.left = (startingX + (currentX - startingX)) + '%';
            }
            if (handlePos.includes('bottom')) {
                box.style.height = startingYheight + (currentY - startingY) + '%';
            } else if (handlePos.includes('top')) {
                box.style.height = (startingYheight - (currentY - startingY)) + '%';
                box.style.top = (startingY + (currentY - startingY)) + '%';
            }

            //get left and top of input box where 0% is the left and top of the slide and 100% is the right and bottom of the slide, get the variables in percentage relativly to the slide
            const rect2 = box.getBoundingClientRect();
            const left = (rect2.left - rect.left) / widthSlidePx * 100;
            const top = (rect2.top - rect.top) / heightSlidePx * 100;
            
            //get the width and height of the input box in percentage relativly to the slide like you did with left and top
            const width = parseInt(boxStyle.width) / widthSlidePx * 100;
            const height = parseInt(boxStyle.height) / heightSlidePx * 100;
           
            updateEditBarWithValues(left,top,width,height, box);
           
        }

        function stopResize() {
            ActionMade();
            document.documentElement.removeEventListener('mousemove', doResize);
            document.documentElement.removeEventListener('mouseup', stopResize);
        }
    }

    function startMove(e, box) {
        e.preventDefault();

        const rect = slide.getBoundingClientRect();
        const rectB = box.getBoundingClientRect();

        const topSlide = rect.top * 100 / window.innerHeight;
        const leftSlide = rect.left * 100 / window.innerWidth;
        const rightSlide = rect.right * 100 / window.innerWidth;
        const bottomSlide = rect.bottom * 100 / window.innerHeight;

        const topBox = rectB.top * 100 / window.innerHeight;
        const leftBox = rectB.left * 100 / window.innerWidth;

        const mouseX = e.clientX * 100 / window.innerWidth;
        const mouseY = e.clientY * 100 / window.innerHeight;

        const startingX = (mouseX - leftSlide) / (rightSlide - leftSlide) * 100;
        const startingY = (mouseY - topSlide) / (bottomSlide - topSlide) * 100;

        const offsetX = (mouseX - leftBox) / (rightSlide - leftSlide) * 100;
        const offsetY = (mouseY - topBox) / (bottomSlide - topSlide) * 100;

        document.documentElement.addEventListener('mousemove', doMove);
        document.documentElement.addEventListener('mouseup', stopMove);

        function doMove(e) {
            var currentX = ((e.clientX * 100 / window.innerWidth) - leftSlide) / (rightSlide - leftSlide) * 100;
            var currentY = ((e.clientY * 100 / window.innerHeight) - topSlide) / (bottomSlide - topSlide) * 100;

            box.style.left = startingX + (currentX - startingX - offsetX) + '%';
            box.style.top = startingY + (currentY - startingY - offsetY) + '%';

            updateEditBarWithValues(startingX + (currentX - startingX - offsetX) + '%', startingY + (currentY - startingY - offsetY) + '%', null, null, box)
        }

        function stopMove() {
            ActionMade();
            document.documentElement.removeEventListener('mousemove', doMove);
            document.documentElement.removeEventListener('mouseup', stopMove);
        }
    }

    //now when the user stop focusing print the input of this element: fontSizeInput

    startingInputValue = "-"

    fontSizeInput.addEventListener('focusin', () => {startingInputValue = fontSizeInput.value;});
    fontSizeInput.addEventListener('focusout', () => {
        if (fontSizeInput.value != startingInputValue){
            if (parseFloat(fontSizeInput.value) && parseFloat(fontSizeInput.value) >= 1 && parseFloat(fontSizeInput.value) < 1000){
                startingInputValue = parseFloat(fontSizeInput.value);
                fontSizeInput.value = startingInputValue;
                if (selectedBox){
                    currentElement = SlideData["slides"][slideNow]["allElements"][selectedBox.id];
                    currentElement.fontSizeVAR = startingInputValue;
                    defaultElement.fontSizeVAR = startingInputValue;
                    selectedBox.querySelector('.input-box-element').style.fontSize = startingInputValue / 10 + "vw";
                }
            } else {
                fontSizeInput.value = startingInputValue || 20;
            }
            
            
        }
    });

    fontStyleInput.addEventListener('change', () => {
        if (selectedBox){
            currentElement = SlideData["slides"][slideNow]["allElements"][selectedBox.id];
            currentElement.fontFamilyVAR = fontStyleInput.value;
            selectedBox.querySelector('.input-box-element').style.fontFamily = fontStyleInput.value;
        }
        defaultElement.fontFamilyVAR = fontStyleInput.value;
    });


    outlineSizeInput.addEventListener('focusin', () => {startingInputValue = outlineSizeInput.value; inputFocused = true;});
    outlineSizeInput.addEventListener('focusout', () => {
        if (outlineSizeInput.value != startingInputValue ){
            if ((parseFloat(outlineSizeInput.value) && parseFloat(outlineSizeInput.value) >= 0 && parseFloat(outlineSizeInput.value) < 1000) || outlineSizeInput.value == 0){
                startingInputValue = parseFloat(outlineSizeInput.value) || 0;
                outlineSizeInput.value = startingInputValue;
                if (selectedBox){
                    currentElement = SlideData["slides"][slideNow]["allElements"][selectedBox.id];
                    currentElement.outlineWidthVAR = startingInputValue;
                    defaultElement.outlineWidthVAR = startingInputValue;
                   
                    if (currentElement.outlineColorVAR || currentElement.outlineWidthVAR || currentElement.outlineWidthVAR === 0){
                        if (currentElement.outlineColorVAR && (currentElement.outlineWidthVAR || currentElement.outlineWidthVAR === 0)){
                            selectedBox.querySelector('.input-box-element').style.border = `${currentElement.outlineWidthVAR / 10}vw solid ${currentElement.outlineColorVAR}`;
                        } else if (currentElement.outlineColorVAR){
                            selectedBox.querySelector('.input-box-element').style.border = `2.5vw solid ${currentElement.outlineColorVAR}`;
                        } else if (currentElement.outlineWidthVAR || currentElement.outlineWidthVAR === 0){
                            selectedBox.querySelector('.input-box-element').style.border = `2.5vw solid #000000`;
                        }
                        console.log(parseFloat(outlineSizeInput.value) );
                    }
                    ActionMade();
                }
            } else {
                outlineSizeInput.value = startingInputValue || 0;
            }
        }
    });

    posXInput.addEventListener('focusin', () => {startingInputValue = posXInput.value; inputFocused = true;});
    posXInput.addEventListener('focusout', () => {
        if (posXInput.value.replace("%","") != startingInputValue){
            if (parseFloat(posXInput.value.replace("%","")) || posXInput.value.replace("%","") == 0){
                startingInputValue = parseFloat(posXInput.value.replace("%",""));
                posXInput.value = startingInputValue + "%";
                currentElement.leftVAR = startingInputValue + "%";
                selectedBox.style.left = startingInputValue + "%";
                ActionMade();
            } else {
                posXInput.value = startingInputValue || 40 + "%";
            }
        }
    });

    posYInput.addEventListener('focusin', () => {startingInputValue = posYInput.value; inputFocused = true;});
    posYInput.addEventListener('focusout', () => {
        if (posYInput.value.replace("%","") != startingInputValue){
            if (parseFloat(posYInput.value.replace("%","")) || posYInput.value.replace("%","") == 0){
                startingInputValue = parseFloat(posYInput.value.replace("%",""));
                posYInput.value = startingInputValue + "%";
                currentElement.topVAR = startingInputValue + "%";
                selectedBox.style.top = startingInputValue + "%";
                ActionMade();
            } else {
                posYInput.value = startingInputValue || 40 + "%";
            }
        }
    });

    sizeXInput.addEventListener('focusin', () => {startingInputValue = sizeXInput.value; inputFocused = true;});
    sizeXInput.addEventListener('focusout', () => {
        if (sizeXInput.value.replace("%","") != startingInputValue){
            if (parseFloat(sizeXInput.value.replace("%","")) || sizeXInput.value.replace("%","") == 0){
                startingInputValue = parseFloat(sizeXInput.value.replace("%",""));
                sizeXInput.value = startingInputValue + "%";
                currentElement.widthVAR = startingInputValue + "%";
                selectedBox.style.width = startingInputValue + "%";
                ActionMade();
            } else {
                sizeXInput.value = startingInputValue || 20 + "%";
            }
        }
    });

    sizeYInput.addEventListener('focusin', () => {startingInputValue = sizeYInput.value; inputFocused = true;});
    sizeYInput.addEventListener('focusout', () => {
        if (sizeYInput.value.replace("%","") != startingInputValue){
            if (parseFloat(sizeYInput.value.replace("%","")) || sizeYInput.value.replace("%","") == 0){
                startingInputValue = parseFloat(sizeYInput.value.replace("%",""));
                sizeYInput.value = startingInputValue + "%";
                currentElement.heightVAR = startingInputValue + "%";
                selectedBox.style.height = startingInputValue + "%";
                ActionMade();
            } else {
                sizeYInput.value = startingInputValue || 20 + "%";
            }
        }
    });


    fontSizeInput.value = 20;
    outlineSizeInput.value = 2;
    posXInput.value = 40 + "%";
    posYInput.value = 40 + "%";
    sizeXInput.value = 20 + "%";
    sizeYInput.value = 20 + "%";

    














































    // when user clicks on element with id="new-page" add a new slide preview under the sidebar with this structure: div class="slide-preview-container">                <div class="slide-preview-text constant-size-text">  [slide number]</div>                <div class="slide-preview"></div>            </div>  the slide number is order of the added element, so count how many elements are under the sidebar:

    function updateEditBarWithValues(left, top, width, height, box){
        function roundAndDisplayPercentage(num){return Math.round(parseFloat(num) * 100) / 100 + "%";}
        if (left){
            posXInput.value = roundAndDisplayPercentage(left);
            if (box && roundAndDisplayPercentage(left)){
                SlideData["slides"][slideNow]["allElements"][box.id].leftVAR = roundAndDisplayPercentage(left);
            }
        }
        if (top){
            posYInput.value = roundAndDisplayPercentage(top);
            if (box && roundAndDisplayPercentage(top)){
                SlideData["slides"][slideNow]["allElements"][box.id].topVAR = roundAndDisplayPercentage(top);
            }
        }
        if (width){
            sizeXInput.value = roundAndDisplayPercentage(width);
            if (box && roundAndDisplayPercentage(width)){
                SlideData["slides"][slideNow]["allElements"][box.id].widthVAR = roundAndDisplayPercentage(width);
            }
        }
        if (width){
            sizeYInput.value = roundAndDisplayPercentage(height);
            if (box && roundAndDisplayPercentage(height)){
                SlideData["slides"][slideNow]["allElements"][box.id].heightVAR = roundAndDisplayPercentage(height);
            }
        }
    }

    function updateTheGui(inputBox,data,allElementsBool){
        fontSizeInput.value = data.fontSizeVAR;
        fontStyleInput.value = data.fontFamilyVAR.toLowerCase();
        outlineSizeInput.value = data.outlineWidthVAR;
        posXInput.value = data.leftVAR;
        posYInput.value = data.topVAR;
        sizeXInput.value = data.widthVAR;
        sizeYInput.value = data.heightVAR;
        currentElement = data;
    }

    boldStyle.addEventListener('click', () => {
        if (selectedBox){
            currentElement = SlideData["slides"][slideNow]["allElements"][selectedBox.id];
            if (currentElement.boldVAR){
                currentElement.boldVAR = false;
                defaultElement.boldVAR = false;
                selectedBox.querySelector('.input-box-element').style.fontWeight = "normal";
            } else {
                currentElement.boldVAR = true;
                defaultElement.boldVAR = true;
                selectedBox.querySelector('.input-box-element').style.fontWeight = "bold";
            }
            ActionMade();
        } else {
            defaultElement.boldVAR = !defaultElement.boldVAR;
        }
        recolorSvg(boldStyle);
    });

    italicStyle.addEventListener('click', () => {
        if (selectedBox){
            currentElement = SlideData["slides"][slideNow]["allElements"][selectedBox.id];
            if (currentElement.italicVAR){
                currentElement.italicVAR = false;
                defaultElement.italicVAR = false;
                selectedBox.querySelector('.input-box-element').style.fontStyle = "normal";
            } else {
                currentElement.italicVAR = true;
                defaultElement.italicVAR = true;
                selectedBox.querySelector('.input-box-element').style.fontStyle = "italic";
            }
            ActionMade();
        } else {
            defaultElement.italicVAR = !defaultElement.italicVAR;
        }
        recolorSvg(italicStyle);
    });

    underlineStyle.addEventListener('click', () => {
        if (selectedBox){
            currentElement = SlideData["slides"][slideNow]["allElements"][selectedBox.id];
            if (currentElement.underlineVAR){
                currentElement.underlineVAR = false;
                defaultElement.underlineVAR = false;
                selectedBox.querySelector('.input-box-element').style.textDecoration = "none";
            } else {
                currentElement.underlineVAR = true;
                defaultElement.underlineVAR = true;
                selectedBox.querySelector('.input-box-element').style.textDecoration = "underline";
            }
            ActionMade();
        } else {
            defaultElement.underlineVAR = !defaultElement.underlineVAR;
        }
        recolorSvg(underlineStyle);
    });

    alignLeft.addEventListener('click', () => {
        if (selectedBox){
            currentElement = SlideData["slides"][slideNow]["allElements"][selectedBox.id];
            currentElement.textAlignVAR = "left";
            selectedBox.querySelector('.input-box-element').style.textAlign = "left";
        }
        defaultElement.textAlignVAR = "left";
        recolorSvg(alignLeft);
        recolorSvg(alignCenter);
        recolorSvg(alignRight);
        recolorSvg(alignBlock);
    });

    alignCenter.addEventListener('click', () => {
        if (selectedBox){
            currentElement = SlideData["slides"][slideNow]["allElements"][selectedBox.id];
            currentElement.textAlignVAR = "center";
            selectedBox.querySelector('.input-box-element').style.textAlign = "center";
            ActionMade();
        }
        defaultElement.textAlignVAR = "center";
            recolorSvg(alignLeft);
            recolorSvg(alignCenter);
            recolorSvg(alignRight);
            recolorSvg(alignBlock);
    });

    alignRight.addEventListener('click', () => {
        if (selectedBox){
            currentElement = SlideData["slides"][slideNow]["allElements"][selectedBox.id];
            currentElement.textAlignVAR = "right";
            selectedBox.querySelector('.input-box-element').style.textAlign = "right";
            ActionMade();
        }
        defaultElement.textAlignVAR = "right";
        recolorSvg(alignLeft);
        recolorSvg(alignCenter);
        recolorSvg(alignRight);
        recolorSvg(alignBlock);
    });

    alignBlock.addEventListener('click', () => {
        if (selectedBox){
            currentElement = SlideData["slides"][slideNow]["allElements"][selectedBox.id];
            currentElement.textAlignVAR = "block";
            selectedBox.querySelector('.input-box-element').style.textAlign = "justify";
            ActionMade();
        }
        defaultElement.textAlignVAR = "block";
        recolorSvg(alignLeft);
        recolorSvg(alignCenter);
        recolorSvg(alignRight);
        recolorSvg(alignBlock);
    });

    insertLink.addEventListener('click', () => {
        var permSelectedBox = selectedBox;
        if (selectedBox){
            currentElement = SlideData["slides"][slideNow]["allElements"][selectedBox.id];
            var link = prompt("Please enter the URL of the link you want to add", currentElement.linkVAR || "https://");
            if (link == null){
                return;
            }
            if ((link.startsWith("https://") && link != "https://") || (link.startsWith("http://") && link != "http://") || link == "" || link == " ") {
                currentElement.linkVAR = link;
                recolorSvg(insertLink);
                if (link != "" && link != null && link != undefined && link != "undefined" && canOpenLinks){
                    permSelectedBox.addEventListener('mouseover', () => {
                        permSelectedBox.style.cursor = "pointer";
                    });
                }
                permSelectedBox.addEventListener('click', () => {
                    if (link != "" && link != null && link != undefined && link != "undefined" && canOpenLinks){
                        window.open(link, '_blank');
                    } else {
                        //fullScreenWhiteClicked();
                    }
                });
                ActionMade();
            }
            UpdateSlidePreview();
        }
    });

    changeImage.addEventListener('click', () => {
        if (selectedBox){
            currentElement = SlideData["slides"][slideNow]["allElements"][selectedBox.id];
            var img = prompt("Please enter the URL of the image you want to add", currentElement.imageSrcVAR || "https://");
            if (img == null){
                return;
            }
            if ((img.startsWith("https://") && img != "https://") || (img.startsWith("http://") && img != "http://") || img == "" || img == " ") {
                currentElement.imageSrcVAR = img;
                selectedBox.querySelector('.input-box-element').style.backgroundImage = `url(${img})`;
                recolorSvg(changeImage);
                ActionMade();
            }
        }
    });

    setBackgroundImage.addEventListener('click', () => {
        SlideData["slides"][slideNow]["generalSlideData"].slideBackgroundImage = prompt("Please enter the URL of the image you want to set the background of the UI", SlideData["slides"][slideNow]["generalSlideData"].slideBackgroundImage) || "";
        if (SlideData["slides"][slideNow]["generalSlideData"].slideBackgroundImage == null || SlideData["slides"][slideNow]["generalSlideData"].slideBackgroundImage == "null" || SlideData["slides"][slideNow]["generalSlideData"].slideBackgroundImage == "undefined" || SlideData["slides"][slideNow]["generalSlideData"].slideBackgroundImage == undefined || SlideData["slides"][slideNow]["generalSlideData"].slideBackgroundImage == "") {
            SlideData["slides"][slideNow]["generalSlideData"].slideBackgroundImage = "";
        } else { 
            blurBackground.style.backgroundImage = `url(${SlideData["slides"][slideNow]["generalSlideData"].slideBackgroundImage})`;
            
            // now create prompt yes / no to set the background image to all slides

            var setToAll = confirm("Do you want to set this background image to all slides? This will also make this the default background image for all new slides.");
            if (setToAll){
                for (var i = 0; i < SlideData["slides"].length; i++){
                    SlideData["slides"][i]["generalSlideData"].slideBackgroundImage = SlideData["slides"][slideNow]["generalSlideData"].slideBackgroundImage;
                }
                defaultBackgroundImage = SlideData["slides"][slideNow]["generalSlideData"].slideBackgroundImage;
            }
        }
    });

    const colorPickerText = document.querySelector('#color-picker-text');
    const colorPickerBackground = document.querySelector('#color-picker-background');
    const colorPickerOutline = document.querySelector('#color-picker-outline');
    const colorPickerSlide = document.querySelector('#color-picker-slide');

    colorPickerText.addEventListener('input', () => {
        if (selectedBox){
            currentElement = SlideData["slides"][slideNow]["allElements"][selectedBox.id];
            if (colorPickerText.value === '#ffffff') {
                currentElement.fontColorVAR = 'transparent';
                selectedBox.querySelector('.input-box-element').style.color = 'transparent';
            } else {
                currentElement.fontColorVAR = colorPickerText.value;
                selectedBox.querySelector('.input-box-element').style.color = colorPickerText.value;
            }
        }
        if (colorPickerText.value === '#ffffff') {
            defaultElement.fontColorVAR = 'transparent';
        } else {
            defaultElement.fontColorVAR = colorPickerText.value;
        }
        recolorSvg(textColor);
    });

    colorPickerBackground.addEventListener('input', () => {
        if (selectedBox){
            currentElement = SlideData["slides"][slideNow]["allElements"][selectedBox.id];
            if (colorPickerBackground.value === '#ffffff') {
                currentElement.backgroundColorVAR = 'transparent';
                selectedBox.querySelector('.input-box-element').style.backgroundColor = 'transparent';
            } else {
                currentElement.backgroundColorVAR = colorPickerBackground.value;
                selectedBox.querySelector('.input-box-element').style.backgroundColor = colorPickerBackground.value;
            }
        }
        if (colorPickerBackground.value === '#ffffff') {
            defaultElement.backgroundColorVAR = 'transparent';
        } else {
            defaultElement.backgroundColorVAR = colorPickerBackground.value;
        }
        recolorSvg(backgroundColor);
    });

    colorPickerOutline.addEventListener('input', () => {
        if (selectedBox){
            currentElement = SlideData["slides"][slideNow]["allElements"][selectedBox.id];
            currentElement.outlineColorVAR = colorPickerOutline.value;
            if (colorPickerOutline.value === '#ffffff') {
                currentElement.outlineColorVAR = 'transparent';
            }
            if (currentElement.outlineColorVAR || currentElement.outlineWidthVAR || currentElement.outlineWidthVAR === 0){
                if (currentElement.outlineColorVAR && (currentElement.outlineWidthVAR || currentElement.outlineWidthVAR === 0)){
                    selectedBox.querySelector('.input-box-element').style.border = `${currentElement.outlineWidthVAR / 10}vw solid ${currentElement.outlineColorVAR}`;
                } else if (currentElement.outlineColorVAR){
                    selectedBox.querySelector('.input-box-element').style.border = `2.5vw solid ${currentElement.outlineColorVAR}`;
                } else if (currentElement.outlineWidthVAR || currentElement.outlineWidthVAR === 0){
                    selectedBox.querySelector('.input-box-element').style.border = `2.5vw solid #000000`;
                }
            }
        }
        defaultElement.outlineColorVAR = colorPickerOutline.value;
        if (colorPickerOutline.value === '#ffffff') {
            defaultElement.outlineColorVAR = 'transparent';
        }
        recolorSvg(outlineColor);
    });

    colorPickerSlide.addEventListener('input', () => {
        if (colorPickerSlide.value === '#ffffff') {
            slide.style.backgroundColor = 'transparent';
        } else {
            slide.style.backgroundColor = colorPickerSlide.value;
        }
        SlideData["slides"][slideNow]["generalSlideData"] .slideColor = colorPickerSlide.value;
        recolorSvg(setSlideColor);
    });

    colorPickerText.addEventListener('focusout', () => {
        ActionMade();
    });

    colorPickerBackground.addEventListener('focusout', () => {
        ActionMade();
    });

    colorPickerOutline.addEventListener('focusout', () => {
        ActionMade();
    });

    colorPickerSlide.addEventListener('focusout', () => {
        ActionMade();
    });

    var powerpointFontSize = [1,2,3,4,5,6,7,8,9,10,11,12,14,16,18,20,22,24,26,28,32,36,40,44,48,54,60,66,72,80,88,96,108,120,132,144,160,180,200,220,240,260,280,300,320,340,360,380,400,450,500,550,600,650,700,800,900,1000];
    var powerpointFontSizeR = [];

    for (var i = powerpointFontSize.length - 1; i >= 0; i--){
        powerpointFontSizeR.push(powerpointFontSize[i]);
    }
    
    increaseTextSize.addEventListener('click', () => {
        var getCurrentTextSize = parseInt(fontSizeInput.value);
        var resized = false;
        if (getCurrentTextSize < 1000 && selectedBox){
            currentElement = SlideData["slides"][slideNow]["allElements"][selectedBox.id];
            powerpointFontSize.forEach(element => {
                if (element > getCurrentTextSize && !resized){
                    fontSizeInput.value = element;
                    currentElement.fontSizeVAR = element;
                    selectedBox.querySelector('.input-box-element').style.fontSize = element / 10 + "vw";
                    resized = true;
                    ActionMade();
                }
            });
        }
    });

    decreaseTextSize.addEventListener('click', () => {
        var getCurrentTextSize = parseInt(fontSizeInput.value);
        var resized = false;
        if (getCurrentTextSize > 1 && selectedBox){
            currentElement = SlideData["slides"][slideNow]["allElements"][selectedBox.id];
            powerpointFontSizeR.forEach(element => {
                if (element < getCurrentTextSize && !resized){
                    fontSizeInput.value = element;
                    currentElement.fontSizeVAR = element;
                    selectedBox.querySelector('.input-box-element').style.fontSize = element / 10 + "vw";
                    resized = true;
                    ActionMade();
                }
            });
        }
    });

    copyStyle.addEventListener('click', () => {
        if (selectedBox){
            currentElement = SlideData["slides"][slideNow]["allElements"][selectedBox.id];
            if (Object.keys(styleCopied).length === 0){
                SlideData["slides"][slideNow]["generalSlideData"] .copyStyle = true;
                for (const [key, value] of Object.entries(currentElement)) {
                    if (value != null){
                        if (key.replace("VAR","") == "left" || key.replace("VAR","") == "top" || key.replace("VAR","") == "width" || key.replace("VAR","") == "height" || key.replace("VAR","") == "layer"){
                            continue;
                        }
                        styleCopied[key.replace("VAR","")] = value;
                    }
                }
            } else {
                styleCopied = {}
                SlideData["slides"][slideNow]["generalSlideData"] .copyStyle = false;
            }
            ActionMade();
        }
    });

    applyStyle.addEventListener('click', () => {
        if (selectedBox){
            currentElement = SlideData["slides"][slideNow]["allElements"][selectedBox.id];
            if (Object.keys(styleCopied).length !== 0){
                for (const [key, value] of Object.entries(styleCopied)) {
                    currentElement[key] = value;
                }
                ApplyStyle(selectedBox, selectedBox.querySelector('.input-box-element'), styleCopied);
                ActionMade();
            }
        }
    });

    function createDropdown(webSafeFonts) {
        const container = document.getElementById("font-style-input");
        
        webSafeFonts.forEach(option => {
            const opt = document.createElement('option');
            opt.value = option.toLowerCase();
            opt.textContent = option;
            opt.style.fontFamily = option;
            container.appendChild(opt);
        });

    }
    
    createDropdown(webSafeFonts);


    function updateLayerIndexes() {
        const boxes = slide.querySelectorAll('.input-box');
        var index = 0;
        boxes.forEach((box) => {
            SlideData["slides"][slideNow]["allElements"][box.id].layerVAR = index + 1;
            index++;
        });
    }

    function moveElementUp(el) {
        // Get the parent element (.window-controls)
        const parent = el.parentNode;
    
        // Get the index of the element to move
        const index = Array.from(parent.children).indexOf(el);
    
        // If the element is not the first one, move it up
        if (index > 0) {
            parent.insertBefore(el, parent.children[index - 1]);
        }
    }
    
    // Function to move element down
    function moveElementDown(el) {
        // Get the parent element (.window-controls)
        const parent = el.parentNode;
    
        // Get the index of the element to move
        const index = Array.from(parent.children).indexOf(el);
    
        // If the element is not the last one, move it down
        if (index < parent.children.length - 1) {
            parent.insertBefore(parent.children[index + 1], el);
        }
    }
    

    layerUp.addEventListener('click', () => {
        if (selectedBox){
            // check if the layer is not the highest layer
            if (currentElement.layerVAR < slide.children.length){
                currentElement = SlideData["slides"][slideNow]["allElements"][selectedBox.id];
                var currentLayer = currentElement.layerVAR;
                var nextElement = slide.querySelectorAll('.input-box')[currentLayer];
                moveElementDown(selectedBox);
                updateLayerIndexes();
                recolorSvg(layerUp);
                recolorSvg(layerDown);
                ActionMade();
            }
        }
    });

    layerDown.addEventListener('click', () => {
        if (selectedBox){
            // check if the layer is not the lowest layer
            if (currentElement.layerVAR > 1){
                currentElement = SlideData["slides"][slideNow]["allElements"][selectedBox.id];
                var currentLayer = currentElement.layerVAR;
                var previousElement = slide.querySelectorAll('.input-box')[currentLayer-2];
                moveElementUp(selectedBox);
                updateLayerIndexes();
                recolorSvg(layerUp);
                recolorSvg(layerDown);
                ActionMade();
            }
        }
    });
    ActionMade()

    const save = document.getElementById("save");
    const upload = document.getElementById("upload");

    function ClearAllSlides(){

        currentDate = new Date();
        year = currentDate.getFullYear();
        month = String(currentDate.getMonth() + 1).padStart(2, '0');
        day = String(currentDate.getDate()).padStart(2, '0');
        hours = String(currentDate.getHours()).padStart(2, '0');
        minutes = String(currentDate.getMinutes()).padStart(2, '0');
        seconds = String(currentDate.getSeconds()).padStart(2, '0');

        formattedDate = `${year}-${month}-${day}-${hours}-${minutes}-${seconds}`;

        SlideData = {
            "slides": [{
                "allElements": {},
                "generalSlideData": {},
                "actionHistory": []
            }],
            "metaData": {
                "title": "Presentation1",
                "description": "",
                "author": userName,
                "authorUpdated": userName,
                "dateCreated": formattedDate,
                "dateModified": formattedDate,
                "defaultBgImage": ""
            }
        };;

        // remove all slide previews:
        var slidePreviews = document.querySelectorAll('.slide-preview-container');
        slidePreviews.forEach(slidePreview => slidePreview.remove());
        // remove all elements from the slide:
        const elementsToRemove = slide.querySelectorAll('.input-box');
        elementsToRemove.forEach(element => element.remove());
        // remove the slide background color:
        slide.style.backgroundColor = 'white';
    }

    function OpenNewPresentation(data){
        for (const [key, value] of Object.entries(data["slides"])) {
            if (key == 0){
                continue;
            }

            createNewSlide(); 
            const slidePreviews = document.querySelectorAll('.slide-preview-container');
            const lastSlidePreviewContainer = slidePreviews[slidePreviews.length - 1];
            const lastSlidePreview = lastSlidePreviewContainer.querySelector('.slide-preview');              

            for (var [key2, value2] of Object.entries(value["allElements"])) {
                for (i = 1; i < Object.entries(value["allElements"]).length+1; i++){
                    if (value2.layerVAR === i){
                        valueNew = {}
                        for (var [key3, value3] of Object.entries(value2)) {
                            valueNew[key3.replace("VAR","")] = value3;
                        }
                        createNewElement(valueNew);
                    }
                }
            }
            UpdateSlidePreview();
        }

        slideChange(document.querySelectorAll('.slide')[0], 1, document.querySelectorAll('.slide-preview')[0]);

        if (data["slides"][slideNow]["generalSlideData"].slideBackgroundImage){
            blurBackground.style.backgroundImage = `url(${data["slides"][slideNow]["generalSlideData"].slideBackgroundImage})`;
        }

        if (data["metaData"]["title"]){
            activeCategory.innerText = data["metaData"]["title"];
            presentationTitle.innerText = data["metaData"]["title"] + " - " + data["metaData"]["author"];
            if (data["metaData"]["authorUpdated"] != data["metaData"]["author"]){
                presentationTitle.innerText = data["metaData"]["title"] + " - "  + data["metaData"]["authorUpdated"] + " (edited by " + data["metaData"]["author"] + ")";
            }
        }
    }

    save.addEventListener('click', () => {
        function downloadTextFile() {
            // Create a new Blob with the text content

            currentDate = new Date();
            year = currentDate.getFullYear();
            month = String(currentDate.getMonth() + 1).padStart(2, '0');
            day = String(currentDate.getDate()).padStart(2, '0');
            hours = String(currentDate.getHours()).padStart(2, '0');
            minutes = String(currentDate.getMinutes()).padStart(2, '0');
            seconds = String(currentDate.getSeconds()).padStart(2, '0');
    
            formattedDate = `${year}-${month}-${day}-${hours}-${minutes}-${seconds}`;

            SlideData["metaData"]["title"] = activeCategory.innerText;
            SlideData["metaData"]["authorUpdated"] = userName;
            SlideData["metaData"]["updated"] = formattedDate;
            SlideData["metaData"]["defaultBgImage"] = defaultBackgroundImage;

            const textContent = JSON.stringify(SlideData);
            const blob = new Blob([textContent], { type: 'text/plain' });
        
            // Create a link element
            const link = document.createElement('a');
            link.href = URL.createObjectURL(blob);

            // replace ONLY all spaces in presentationName to _

            var presentationName = activeCategory.innerText.replace(/ /g, "_");
            presentationName = presentationName.replace(/[^a-zA-Z0-9-_]/g, '');

            if (presentationName === "") {
                presentationName = "Presentation";
            }

            presentationName.replace(" ","_");
            link.download = presentationName+".profi";
        
            // Programmatically click the link to trigger the download
            link.click();

            // Clean up by revoking the object URL
            URL.revokeObjectURL(link.href);
        }
        
        // Call the function to download the file
        downloadTextFile();
    });

    upload.addEventListener('click', () => {
        
        var input = document.createElement('input');
        input.type = 'file';
        input.accept = '.profi';

        //activate the input:
        input.click();

        //when the file is selected:
        input.addEventListener('change', () => {
            const file = input.files[0];
            const reader = new FileReader();
            const fileName = file.name.replace('.profi', '').replace(/_/g, ' ');

            activeCategory.innerText = fileName;

            underline.style.transition = 'transform 0.1s ease, width 0.1s ease';
            underline.style.transform = 'scaleX(0)';
            setTimeout(() => {
                updateUnderline();
                underline.style.transform = 'scaleX(1)';
            }, 100);

            reader.onload = function(e) {
            const fileContent = e.target.result;
            var SlideDataNEW = JSON.parse(fileContent);

            ClearAllSlides();
            OpenNewPresentation(SlideDataNEW);

            defaultBackgroundImage = SlideDataNEW["metaData"]["defaultBgImage"] || "";
            
            }
            reader.readAsText(file);
        });
        input.remove();
    });

    const aboutC = document.getElementById("about-c");
    const videosC = document.getElementById("videos-c");
    const codingC = document.getElementById("coding-c");
    const projectsC = document.getElementById("projects-c");
    const labawardsC = document.getElementById("labawards-c");
    const tutorialC = document.getElementById("tutorial-c");

    var firstLoadedMoment = false;
    aboutC.addEventListener('click', () => {
        checkIfIsInUserCreatedMode();
        isInUserCreatedMode = false;
        fetch('./presentations/Test.profi')
        .then(response => response.text())
        .then(data => {
            var SlideDataNEW = JSON.parse(data);
            ClearAllSlides();
            OpenNewPresentation(SlideDataNEW);
            firstLoadedMoment = true;
        });
    });

    videosC.addEventListener('click', () => {
        checkIfIsInUserCreatedMode();
        isInUserCreatedMode = false;
        fetch('./presentations/Other.profi')
        .then(response => response.text())
        .then(data => {
            var SlideDataNEW = JSON.parse(data);
            ClearAllSlides();
            OpenNewPresentation(SlideDataNEW);
            firstLoadedMoment = true;
        });
    });

    codingC.addEventListener('click', () => {
        checkIfIsInUserCreatedMode();
        isInUserCreatedMode = false;
        fetch('./presentations/Test.profi')
        .then(response => response.text())
        .then(data => {
            var SlideDataNEW = JSON.parse(data);
            ClearAllSlides();
            OpenNewPresentation(SlideDataNEW);
            firstLoadedMoment = true;
        });
    });

    projectsC.addEventListener('click', () => {
        checkIfIsInUserCreatedMode();
        isInUserCreatedMode = false;
        fetch('./presentations/Other.profi')
        .then(response => response.text())
        .then(data => {
            var SlideDataNEW = JSON.parse(data);
            ClearAllSlides();
            OpenNewPresentation(SlideDataNEW);
            firstLoadedMoment = true;
        });
    });

    labawardsC.addEventListener('click', () => {
        checkIfIsInUserCreatedMode();
        isInUserCreatedMode = false;
        fetch('./presentations/Test.profi')
        .then(response => response.text())
        .then(data => {
            var SlideDataNEW = JSON.parse(data);
            ClearAllSlides();
            OpenNewPresentation(SlideDataNEW);
            firstLoadedMoment = true;
        });
    });

    tutorialC.addEventListener('click', () => {
        checkIfIsInUserCreatedMode();
        isInUserCreatedMode = false;
        fetch('./presentations/Other.profi')
        .then(response => response.text())
        .then(data => {
            var SlideDataNEW = JSON.parse(data);
            ClearAllSlides();
            OpenNewPresentation(SlideDataNEW);
            firstLoadedMoment = true;
        });
    });


    function checkIfIsInUserCreatedMode(){
        if (isInUserCreatedMode){
            UserMadePresentation[numOfCurrentPresentation] = JSON.stringify(SlideData);
            if (JSON.stringify(SlideData)) {

            } else {

                currentDate = new Date();
                year = currentDate.getFullYear();
                month = String(currentDate.getMonth() + 1).padStart(2, '0');
                day = String(currentDate.getDate()).padStart(2, '0');
                hours = String(currentDate.getHours()).padStart(2, '0');
                minutes = String(currentDate.getMinutes()).padStart(2, '0');
                seconds = String(currentDate.getSeconds()).padStart(2, '0');

                formattedDate = `${year}-${month}-${day}-${hours}-${minutes}-${seconds}`;

                UserMadePresentation[numOfCurrentPresentation] = {
                    "slides": [{
                        "allElements": {},
                        "generalSlideData": {},
                        "actionHistory": []
                    }],
                    "metaData": {
                        "title": "Presentation1",
                        "description": "",
                        "author": userName,
                        "authorUpdated": userName,
                        "dateCreated": formattedDate,
                        "dateModified": formattedDate,
                        "defaultBgImage": ""
                    }
                };
            }
            SlideData = {}
        } else {
        }
    }

    

    var numOfUserPresentations = 0;
    var numOfCurrentPresentation = 0;

    function createNewPresentationClick(){
        checkIfIsInUserCreatedMode(numOfCurrentPresentation);
        isInUserCreatedMode = true;
        const saveThisNumberOfPresentation = numOfUserPresentations;
        numOfCurrentPresentation = saveThisNumberOfPresentation;
        ClearAllSlides();


        currentDate = new Date();
        year = currentDate.getFullYear();
        month = String(currentDate.getMonth() + 1).padStart(2, '0');
        day = String(currentDate.getDate()).padStart(2, '0');
        hours = String(currentDate.getHours()).padStart(2, '0');
        minutes = String(currentDate.getMinutes()).padStart(2, '0');
        seconds = String(currentDate.getSeconds()).padStart(2, '0');

        formattedDate = `${year}-${month}-${day}-${hours}-${minutes}-${seconds}`;


        var prevSlideDataTitle = SlideData["metaData"]["title"];

            SlideData = {
                "slides": [{
                    "allElements": {},
                    "generalSlideData": {},
                    "actionHistory": []
                }],
                "metaData": {
                    "title": activeCategory.innerText,
                    "description": "",
                    "author": userName,
                    "authorUpdated": userName,
                    "dateCreated": formattedDate,
                    "dateModified": formattedDate,
                    "defaultBgImage": ""
                }
            };

            if (SlideData["metaData"]["title"] == "CREATE+"){
                SlideData["metaData"]["title"] = prevSlideDataTitle;
            }

        createNewSlide();

        // now add under categories this element: <div id="presentation-1" class="category constant-size-text">Presentation 1</div>
        const categories = document.querySelector(".categories");
        const newPresentation = document.createElement('div');
        newPresentation.id = "presentation-1";
        newPresentation.className = "category constant-size-text user-made-presentation";
        newPresentation.textContent = "Presentation " + (numOfUserPresentations + 1);
        categories.appendChild(newPresentation);

        underline.style.transition = 'transform 0.1s ease, width 0.1s ease';
        underline.style.transform = 'scaleX(0)';
        setTimeout(() => {
            updateUnderline();
            underline.style.transform = 'scaleX(1)';
        }, 100);

        // Update active category
        activeCategory = newPresentation;

        newPresentation.addEventListener('click', () => {

            
            checkIfIsInUserCreatedMode();
            numOfCurrentPresentation = saveThisNumberOfPresentation;

            // Animation for underline
            underline.style.transition = 'transform 0.1s ease, width 0.1s ease';
            underline.style.transform = 'scaleX(0)';
            setTimeout(() => {
                updateUnderline();
                underline.style.transform = 'scaleX(1)';
            }, 100);

            // Update active category
            activeCategory = newPresentation;

            currentDate = new Date();
            year = currentDate.getFullYear();
            month = String(currentDate.getMonth() + 1).padStart(2, '0');
            day = String(currentDate.getDate()).padStart(2, '0');
            hours = String(currentDate.getHours()).padStart(2, '0');
            minutes = String(currentDate.getMinutes()).padStart(2, '0');
            seconds = String(currentDate.getSeconds()).padStart(2, '0');
            
            formattedDate = `${year}-${month}-${day}-${hours}-${minutes}-${seconds}`;

            var prevSlideDataTitle = SlideData["metaData"]["title"];

            SlideData = {
                "slides": [{
                    "allElements": {},
                    "generalSlideData": {},
                    "actionHistory": []
                }],
                "metaData": {
                    "title": activeCategory.innerText,
                    "description": "",
                    "author": userName,
                    "authorUpdated": userName,
                    "dateCreated": formattedDate,
                    "dateModified": formattedDate,
                    "defaultBgImage": ""
                }
            };

            if (SlideData["metaData"]["title"] == "CREATE+"){
                SlideData["metaData"]["title"] = prevSlideDataTitle;
            }

            ClearAllSlides();

            SlideDataTemp = JSON.parse(UserMadePresentation[numOfCurrentPresentation]);
            
            OpenNewPresentation(SlideDataTemp);
            
            isInUserCreatedMode = true;

        });
        numOfUserPresentations++;
    }


    createNewPresentation.addEventListener('click', () => {
        createNewPresentationClick();
    });



    deleteSlideButton.addEventListener('click', () => {
        // delete the current slide
        var slidePreview = document.querySelectorAll('.slide-preview')[slideNow-1];
        slidePreview.parentNode.remove();
        // update the slide numbering?:
        var slidePreviews = document.querySelectorAll('.slide-preview-container');
        slidePreviews.forEach((slidePreview, index) => {
            slidePreview.querySelector('.slide-preview-text').textContent = index + 1;
        });
        // remove all elements from the slide:
        const elementsToRemove = slide.querySelectorAll('.input-box');
        elementsToRemove.forEach(element => element.remove());
        // remove the data from the SlideData array:
        SlideData["slides"].splice(slideNow, 1);
    });

    profiLogo.addEventListener('click', () => {
        window.location.href = "https://profipoint.pro";
    });

    async function checkUrlAtributes(){
        if (window.location.href.split("#")[0] === "https://profipoint.pro/" || window.location.href.split("#")[0] === "http://127.0.0.1:5500/"){
            aboutC.click();
            return;
        }

        console.log("checkUrlAtributes");
        const urlParams = getAllUrlParams(url);
        // p ... presentation
        // m ... mode (present: fullscreen, edit:editmode, view:edit for pc, view for mobile)
        // s ... slide
        if (urlParams.p) {
            // check if the presentation exists under the categories if so simulate the click
            const categories = document.querySelectorAll(".category");
            console.log(categories);
            // now check if the text of the categories is the same as the urlParams.p, 1 check for the same text, 2) check for the same text without spaces 3) check for the same text without spaces and lower case
            var found = false;   
            if (urlParams.p.toLowerCase() == "create" || urlParams.p.toLowerCase() == "new" || urlParams.p.toLowerCase() == "blank" || urlParams.p.toLowerCase() == "newpresentation" || urlParams.p.toLowerCase() == "make"){
                createNewPresentationClick();
                found = true;
            }
            for (let i = 0; i < categories.length; i++) {
                if (found === false && categories[i].textContent === urlParams.p || categories[i].textContent.replace(/\s/g, '') === urlParams.p || categories[i].textContent.replace(/\s/g, '').toLowerCase() === urlParams.p) {
                    categories[i].click();
                    for (let j = 0; j < 100; j++) {
                        await wait(100);
                        if (firstLoadedMoment){
                            found = true;
                            break;
                        }
                    }                    
                }
            }
            if (!found){
                console.log("Presentation not found");
            }
        }
        if (urlParams.s) {
            // check if the slide exists in the presentation
            console.log("Slide exists");
            console.log(SlideData["slides"]);
            if (SlideData["slides"][urlParams.s]){
                console.log("Slide exists");
                slideChange(document.querySelectorAll('.slide')[0], urlParams.s, document.querySelectorAll('.slide-preview')[urlParams.s - 1]);
            }
        } else if (specialParams ){
            var locNum = parseInt(specialParams.split("-")[1])
            if (locNum && SlideData["slides"][locNum]){
                console.log("Slide exists", locNum);
                slideChange(document.querySelectorAll('.slide')[0], locNum, document.querySelectorAll('.slide-preview')[locNum - 1]);
            }
        }
        if (urlParams.m){
            if (urlParams.m === "present"){
                presentationMode(true);
            } else if (urlParams.m === "edit"){
                
            } else if (urlParams.m === "view"){
                if (isMobile){
                    console.log("view mobile");
                    presentationMode(true);
                }
            }
        } else if (specialParams && specialParams.split("-")[0] == "present"){
            presentationMode(true);
        }
    }

    checkUrlAtributes()

});



