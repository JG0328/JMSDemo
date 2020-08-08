<!DOCTYPE html>
<html lang="sp">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <title>JMS Demo</title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-secondary">
<div class="container">
    <div class="row mt-5">
        <div class="col-md-12">
            <div class="text-light text-center">
                <h2>JMS Demo - ActiveMQ</h2>
            </div>
        </div>
    </div>
    <div class="row my-5">
        <div class="col-md-6 mb-3">
            <div class="card shadow">
                <div class="card-header">
                    <h3 class="card-title m-0">Temperature</h3>
                </div>
                <div id="tempChart" style="height: 300px; width: 100%;"></div>
                <div class="card-footer">
                    <h4 class="m-0">Data: <span id="temperature">-1</span></h4>
                </div>
            </div>
        </div>
        <div class="col-md-6 mb-3">
            <div class="card shadow">
                <div class="card-header">
                    <h3 class="card-title m-0">Humidity</h3>
                </div>
                <div id="humChart" style="height: 300px; width: 100%;"></div>
                <div class="card-footer">
                    <h4 class="m-0">Data: <span id="humidity">-1</span></h4>
                </div>
            </div>
        </div>
    </div>
</div>
<script src="https://code.jquery.com/jquery-3.5.1.min.js"
        integrity="sha256-9/aliU8dGd2tb6OSsuzixeV4y/faTqgFtohetphbbj0=" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.bundle.min.js"></script>
<script src="http://canvasjs.com/assets/script/canvasjs.min.js"></script>
<script>
    var webSocket;
    var tempDataPoints = [];
    var temp = 0;
    var hum = 0;
    var humDataPoints = [];
    var tempChart = new CanvasJS.Chart("tempChart", {
        zoomEnabled: true,
        axisX: {
            title: "Time",
            interval: 30,
            intervalType: "second"
        },
        axisY: {
            title: "Temperature",
            includeZero: false
        },
        data: [{
            type: "line",
            dataPoints: tempDataPoints,
            lineColor: '#a3333a',
            color: '#56070c'
        }]
    });
    var humidityChart = new CanvasJS.Chart("humChart", {
        zoomEnabled: true,
        axisX: {
            title: "Time",
            interval: 30,
            intervalType: "second"
        },
        axisY: {
            title: "Humidity",
            includeZero: false
        },
        data: [{
            type: "line",
            dataPoints: humDataPoints,
            lineColor: '#5dc1b9',
            color: '#1a6862'
        }]
    });
    var updateInterval = 1000;
    var dataLength = 20;
    var updateChart = function (dataPoints) {
        var dp = JSON.parse(dataPoints);
        console.log(dp);
        tempDataPoints.push({
            label: dp.date,
            y: dp.temperature
        });
        humDataPoints.push({
            label: dp.date,
            y: dp.humidity
        });
        var tempElem = document.getElementById("temperature");
        var humElem = document.getElementById("humidity");
        temp = parseInt(tempElem.innerText) + 1;
        tempElem.innerText = temp.toString();
        hum = parseInt(humElem.innerText) + 1;
        humElem.innerText = temp.toString();
        tempChart.render();
        humidityChart.render();
    };

    function socketConnect() {
        webSocket = new WebSocket("ws://" + location.hostname + ":" + location.port + "/sensor_read");
        webSocket.onmessage = function (x) {
            updateChart(x.data);
        };
    }

    function connect() {
        if (!webSocket || webSocket.readyState === 3) {
            socketConnect();
        }
    }

    updateChart(dataLength);
    setInterval(connect, updateInterval);
</script>
</body>
</html>