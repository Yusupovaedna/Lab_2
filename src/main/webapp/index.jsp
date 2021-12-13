<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Лабораторная №2</title>
</head>
<body>
<table id="mainTable" class="shaded">
    <thead>
    <td colspan="5"><h3>Валидация введённых значений:</h3></td>
    </thead>
    <tbody>
    <tr>
        <td colspan="5">
            <hr>
        </td>
    </tr>
    <tr>
        <td rowspan="3">Выберите X:</td>
        <td rowspan="6">
            <svg xmlns="http://www.w3.org/2000/svg" width="300" height="300">
                <%--                figures--%>
                <rect x="30" y="90" width="120" height="60" stroke="#D9EDFF" fill="#D9EDFF"></rect>
                <polygon points="150,150 30,150 150,210" stroke="#D9EDFF" fill="#D9EDFF"></polygon>
                <path d="M210 150C210 116.863 183.137 90 150 90V150H210Z" stroke="#D9EDFF" fill="#D9EDFF"></path>


                <line x1="0" y1="150" x2="300" y2="150" stroke="#000720"></line>
                <line x1="150" y1="0" x2="150" y2="300" stroke="#000720"></line>
                <line x1="270" y1="148" x2="270" y2="152" stroke="#000720"></line>
                <text x="265" y="140">R</text>
                <line x1="210" y1="148" x2="210" y2="152" stroke="#000720"></line>
                <text x="200" y="140">R/2</text>
                <line x1="90" y1="148" x2="90" y2="152" stroke="#000720"></line>
                <text x="75" y="140">-R/2</text>
                <line x1="30" y1="148" x2="30" y2="152" stroke="#000720"></line>
                <text x="20" y="140">-R</text>
                <line x1="148" y1="30" x2="152" y2="30" stroke="#000720"></line>
                <text x="156" y="35">R</text>
                <line x1="148" y1="90" x2="152" y2="90" stroke="#000720"></line>
                <text x="156" y="95">R/2</text>
                <line x1="148" y1="210" x2="152" y2="210" stroke="#000720"></line>
                <text x="156" y="215">-R/2</text>
                <line x1="148" y1="270" x2="152" y2="270" stroke="#000720"></line>
                <text x="156" y="275">-R</text>
                <polygon points="300,150 295,155 295, 145" fill="#000720" stroke="#000720"></polygon>
                <polygon points="150,0 145,5 155,5" fill="#000720" stroke="#000720"></polygon>

                <circle id="pointer" r="2" cx="150" cy="150" fill-opacity="0.4" fill="#FFA9A9" stroke="#FFA9A9"
                        visibility="hidden"></circle>
            </svg>
        </td>
    </tr>
    <tr>
        <td><input type="radio" name="X-button" value="-5"/>-5</td>
        <td><input type="radio" name="X-button" value="-4"/>-4</td>
        <td><input type="radio" name="X-button" value="-3"/>-3</td>
    </tr>
    <tr>
        <td><input type="radio" name="X-button" value="-2"/>-2</td>
        <td><input type="radio" name="X-button" value="-1"/>-1</td>
        <td><input type="radio" name="X-button" value="0"/>0</td>
    </tr>
    <tr>
        <td><input type="radio" name="X-button" value="1"/>1</td>
        <td><input type="radio" name="X-button" value="2"/>2</td>
        <td><input type="radio" name="X-button" value="3"/>3</td>
    </tr>

    <tr>
        <td>Введите Y:</td>
        <td colspan="3"><input required name="Y-input" class="illuminated animated" type="text"
                               placeholder="от -5 до 5" maxlength="6"></td>
    </tr>
    <tr>
        <td rowspan="2">Выберите R: </td>
        <br>

        <td><input name="radius" type="button" class="illuminated animated" value="1"></td>
        <td><input name="radius" type="button" class="illuminated animated" value="1.5"></td>
        <td><input name="radius" type="button" class="illuminated animated" value="2"></td>
        <td><input name="radius" type="button" class="illuminated animated" value="2.5"></td>
        <td><input name="radius" type="button" class="illuminated animated" value="3"></td>

    </tr>


    <tr>
        <td colspan="5">
            <button id="checkButton">Проверить</button>
            <hr>
        </td>
    </tr>
    </tbody>
    <tfoot>
    <tr>
        <td colspan="5" id="outputContainer"><h4><span class="outputStub notification">Результаты отсутствуют</span>
        </h4></td>
    </tr>
    </tfoot>
</table>
<script>
    let request = "x=0" + "&y=0" + "&r=0" + "&key=update";
    fetch("app", {
        method: "POST",
        headers: {"Content-Type": "application/x-www-form-urlencoded; charset=UTF-8"},
        body: request
    }).then(response => response.text()).then(function (serverAnswer) {
        document.getElementById("outputContainer").innerHTML = serverAnswer;
    }).catch(err => createNotification(`Ошибка HTTP ${err.textContent}. Повторите попытку позже.`));
</script>
<script src="scripts/validator.js"></script>
<script src="scripts/easter_egg.js"></script>
<script src="scripts/graph_drawer.js"></script>

</body>
</html>