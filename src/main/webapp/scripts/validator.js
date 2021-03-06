"use strict";

let x, y, r;

//Обновляет значение x в соответсвии с нажатой кнопкой, добавляет ей эффекты (подсветка и увеличение), убирая их для остальных кнопок группы.
document.addEventListener("DOMContentLoaded", () => {
    let buttons = document.querySelectorAll("input[name=radius]");
    buttons.forEach(click);

    function click(element) {
        element.onclick = function () {
            r = this.value;
            buttons.forEach(function (element) {
                element.style.boxShadow = null;
                element.style.backgroundColor = null;
                element.style.color = null;
            });
            this.style.backgroundColor = "#f41c52";
            this.style.color = "white";
        }
    }
});

document.getElementById("checkButton").onclick = function () {
    if (validateX() && validateY() && validateR()) sendRequest("button");
};

//Параметр key установливает, тип запроса обработки точки на сервере: "button" - для клика по кнопке, "svg" - для клика по канвасу.
function sendRequest(key) {
    const keys = ["button", "svg"];
    if (keys.includes(key)) {

        fetch("./app?x=" + encodeURI(x) + "&y=" + encodeURI(y) + "&r=" + encodeURI(r) + "&key=" + encodeURI(key), {
            method: 'GET',
            headers: {
                'Content-Type': 'text/plain;charset=UTF-8'
            }
        }).then(response => response.text()).then(function (serverAnswer) {
            document.getElementById("outputContainer").innerHTML = serverAnswer;
        }).catch(err => createNotification(`Ошибка HTTP ${err.textContent}. Повторите попытку позже.`));
    } else throw new Error("Не указан ключ отправки");
}

function createNotification(message) {
    let outputContainer = document.getElementById("outputContainer");
    if (outputContainer.contains(document.querySelector(".notification"))) {
        let stub = document.querySelector(".notification");
        stub.textContent = message;
        stub.classList.replace("outputStub", "errorStub");
    } else {
        let notificationTableRow = document.createElement("h4");
        notificationTableRow.innerHTML = "<span class='notification errorStub'></span>";
        outputContainer.prepend(notificationTableRow);
        let span = document.querySelector(".notification");
        span.textContent = message;
    }
}

function validateX() {
    if (isNumeric(x)) return true;
    else {
        createNotification("x не выбран");
        return false;
    }
}

function validateY() {
    y = document.querySelector("input[name=Y-input]").value.replace(",", "."); //замена разделителя дробной части числа
    if (y === undefined) {
        createNotification("y не введён");
        return false;
    } else if (!isNumeric(y)) {
        createNotification("y не число");
        return false;
    } else if (!((y >= -5) && (y <= 5))) {
        createNotification("y не входит в область допустимых значений");
        return false;
    } else return true;
}

function validateR() {
    if (isNumeric(r)) return true;
    else {
        createNotification("r не выбран");
        return false;
    }
}

function isNumeric(n) {
    return !isNaN(parseFloat(n)) && isFinite(n);
}