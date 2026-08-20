<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Highway Racer</title>

<style>
*{box-sizing:border-box;margin:0;padding:0}
body{
  overflow:hidden;
  background:#111;
  font-family:Arial;
  touch-action:none;
}
canvas{
  display:block;
  margin:auto;
  background:#333;
}
#start{
  position:fixed;
  inset:0;
  background:rgba(0,0,0,.8);
  color:white;
  display:flex;
  flex-direction:column;
  align-items:center;
  justify-content:center;
  z-index:5;
}
#start h1{font-size:40px;margin-bottom:15px}
button{
  padding:15px 35px;
  font-size:20px;
  border:0;
  border-radius:12px;
  background:#00d9ff;
}
#score{
  position:fixed;
  top:15px;
  left:15px;
  color:white;
  font-size:22px;
  font-weight:bold;
  z-index:3;
}
.controls{
  position:fixed;
  bottom:20px;
  width:100%;
  display:flex;
  justify-content:space-between;
  padding:0 25px;
  z-index:3;
}
.controls button{
  width:80px;
  height:65px;
  padding:0;
  font-size:30px;
  background:rgba(255,255,255,.7);
}
</style>
</head>

<body>

<div id="start">
  <h1>🏎️ HIGHWAY RACER</h1>
  <p style="margin-bottom:20px">Traffic se bachao!</p>
  <button onclick="startGame()">START GAME</button>
</div>

<div id="score">Score: 0</div>

<canvas id="game"></canvas>

<div class="controls">
  <button id="left">⬅️</button>
  <button id="right">➡️</button>
</div>

<script>
const canvas=document.getElementById("game");
const ctx=canvas.getContext("2d");

function resize(){
  canvas.width=Math.min(innerWidth,500);
  canvas.height=innerHeight;
}
resize();
addEventListener("resize",resize);

let player
