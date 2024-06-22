// Get the URL of the page
const url = window.location.href;
const specialParams = window.location.href.split("#")[1]

function checkCookies() {
    // Check if cookies are enabled
    if (navigator.cookieEnabled) {
        console.log("Cookies are enabled");
    } else {
        console.log("Cookies are disabled");
    }
}

function createCookie(name, value, days) {
    let expires = "";
    if (days) {
        const date = new Date();
        date.setTime(date.getTime() + (days * 24 * 60 * 60 * 1000));
        expires = "; expires=" + date.toUTCString();
    }
    document.cookie = name + "=" + value + expires + "; path=/";
}

function getCookie(name) {
    const nameEQ = name + "=";
    const ca = document.cookie.split(';');
    for (let i = 0; i < ca.length; i++) {
        let c = ca[i];
        while (c.charAt(0) === ' ') {
            c = c.substring(1, c.length);
        }
        if (c.indexOf(nameEQ) === 0) {
            return c.substring(nameEQ.length, c.length);
        }
    }
    return null;
}

function checkUsernameHash(content) {
    return content
}

function checkForGuestUser(content) {
    userCanLogIn = true;

    if (content) {
        return content
    }
    // create random guest username followed by a random number Guestxxxxxxxxx
    const guestName = Math.floor(Math.random() * 1000000000);
    createCookie("guest", guestName, 365*10);
}

var userCanLogIn = false;
var userName = checkUsernameHash(getCookie("username")) || "Guest" + checkForGuestUser(getCookie("guest"));

console.log(userName);

// now if in the url is ?p=presentation then redirect it to ./presentation
function getAllUrlParams(url) {
    const queryString = url ? url.split('?')[1] : window.location.search.slice(1);
    const obj = {};
    if (queryString) {
        queryString.split('&').forEach(function (part) {
            const item = part.split('=');
            obj[item[0]] = decodeURIComponent(item[1]).split("#")[0];
        });
    }
    return obj;
}

function setUrlAtributes(){
    let url = window.location.href;
    url = url.split("#")[0];

    var nameOfTheMode = "edit";

    if (canExitPresentation == false && isFullscreen == true){
        nameOfTheMode = "present";
    }

    const newUrl = url + "#" + nameOfTheMode + "-" + slideNow;
    window.location.href = newUrl;
}


