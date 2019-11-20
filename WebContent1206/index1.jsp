<%@ page contentType="text/html; charset=utf-8" %>
<%@ page language="java" import="java.io.*,java.sql.*,java.util.*" %> 
<% request.setCharacterEncoding("utf-8"); %>
<!DOCTYPE html>
<html>


<head>
    <meta charset="utf-8" />

    <script>
        ////////////////////// MainScene 변수들//////////////////////////
        var canvas;
        var ctx;

        var blockArray = [];
        var board = {};
        var ball = {};
        var drawTimerID = 0;
        var updateTimerID = 0;

        var life;   // 목숨
        var score;  // 점수  블럭을 삭제한 갯수
        var leftKeyPressed;     // 왼쪽 화살표 키 입력 감지 불값
        var rightKeyPressed;    // //
        var isXCollision;       // 보드의 x축 충돌 여부
        var unableCount;        // 삭제된 블럭갯수 블럭갯수가 전체 블럭갯수가 되면 게임 클리어!

        //////////////////////// TitleScene 변수들///////////////////////////////

        var titleLogo = {}; 
        var playBtn = {};
        var titleDrawTimerID = 0;       // setInterval의 반환값을 받는 변수 이게 있어야 clearIntval
        var titleUdateTimerID = 0;
        
        ////////////////////////////////////////////////////////////////////////

        function initTitleScene() {
            canvas = document.getElementById('alka');
            if (canvas.getContext) {
                ctx = canvas.getContext('2d');      // draw render 를 하는 도구들
            } else {
                alert("ERROR : context를 얻어오지 못했습니다.")
                return;
            }

            initTitleLogo();
            initPlayBtn();

            titleDrawTimerID = setInterval(titleSceneDraw, 10);
            titleUpdateTimerID = setInterval(titleSceneUpdate, 10);

            document.addEventListener("mousedown", mouseDownHandler, false);
        }

        function clickPlayBtn() {
            changeScene();      // playBtn이 클릭됐다면 씬 전환
        }

        function changeScene() {
            ctx.clearRect(0, 0, canvas.width, canvas.height);

            clearInterval(titleDrawTimerID);    //타이틀씬의 드로우함수 릴리즈
            clearInterval(titleUpdateTimerID);  // //타이틀씬의 update함수 릴리즈

            init();     // MainScene 세팅
            playBtn.x = -100;
            playBtn.y = -100;
            setPosition(playBtn, playBtn.x, playBtn.y );
        }

        function initPlayBtn() {
            playBtn.x = 330;
            playBtn.y = 450;
            playBtn.width = 150;
            playBtn.height = 50;
            playBtn.img = document.getElementById('play');
            setPosition(playBtn, playBtn.x, playBtn.y);
        }

        function initTitleLogo() {
            titleLogo.x = 230;
            titleLogo.y = 50;
            titleLogo.width = 400;
            titleLogo.height = 170;
            titleLogo.img = document.getElementById('titleLogo');
            setPosition(titleLogo, titleLogo.x, titleLogo.y);
        }

        function titleSceneDraw() {
            ctx.clearRect(0, 0, canvas.width, canvas.height); // rect영역을 지움

            ctx.drawImage(titleLogo.img, titleLogo.x, titleLogo.y, titleLogo.width, titleLogo.height);
            ctx.drawImage(playBtn.img, playBtn.x, playBtn.y, playBtn.width, playBtn.height);
        }

        function titleSceneUpdate() {

        }

        function mouseDownHandler(e) {

            var rect = canvas.getBoundingClientRect();

            mouseX = e.clientX - rect.left;
            mouseY = e.clientY - rect.top;

            console.log(mouseX, mouseY);
            console.log(playBtn.x, playBtn.y);

            // 플레이 버튼 충돌감지
            if (playBtn.x < mouseX && playBtn.x + playBtn.width > mouseX && playBtn.y < mouseY && playBtn.y + playBtn.height > mouseY) {
                clickPlayBtn();
            }

        }

        /////////////// MainScene의 init함수 ////////////////////////
        function init() {

            leftKeyPressed = false;
            rightKeyPressed = false;
            score = 0;
            gameOver = false;
            isXCollision = false;
            life = 1;
            unableCount = 0;

            initBall();
            initBlock();
            initBoard();

            drawTimerID = setInterval(draw, 10); // 10ms 마다 draw, update 함수 호출
            updateTimerID = setInterval(update, 10);

            document.addEventListener("keydown", KeyDownHandler, false); // 이벤트 핸들러에 등록
            document.addEventListener("keyup", KeyUpHandler, false);
        }

        function initBall() {
            ball.x = 400;
            ball.y = 400;
            ball.width = 20;
            ball.height = 20;
            
            setPosition(ball, ball.x, ball.y);  // setposition을 해주는 이유는 가변적인 top bottom left right 계산때문
            ball.dirX = 0;                      // 1과-1의 사잇값만 갖는 방향벡터 direction vector
            ball.dirY = -1;
            ball.moveSpeed = 1.8;
            ball.img = document.getElementById('ball');
        }

        function initBlock() {
            for (var i = 0; i < 6; i++) {
                for (var j = 0; j < 15; j++) {
                    block = {};
                    block.isAble = true;
                    block.x = 30 + (j * 50);
                    block.y = 50 + (i * 26);
                    block.width = 48;
                    block.height = 24;
                    setPosition(block, block.x, block.y);
                    if (i % 2) block.img = document.getElementById('block1');
                    else block.img = document.getElementById('block2');
                    blockArray.push(block);
                }
            }
        }

        function initBoard() {
            board.x = 100;
            board.y = 500;
            board.width = 100;
            board.height = 20;
            setPosition(board, board.x, board.y);
            board.img = document.getElementById('board');
        }

        function draw() {
            if (gameOver) return;
            ctx.clearRect(0, 0, canvas.width, canvas.height);

            ctx.drawImage(board.img, board.x, board.y, board.width, board.height);
            ctx.drawImage(ball.img, ball.x, ball.y, ball.width, ball.height);
            drawBlock();

            ctx.font = "20px Arial";
            ctx.fillStyle = "white";
            ctx.fillText("SCORE : " + score, 350, 40);
            ctx.fillText("LIFE : " + life, 150, 40);
        }

        function drawBlock() {
            for (var i = 0; i < 6 * 15; i++) {
                if (!blockArray[i].isAble) continue;
                ctx.drawImage(blockArray[i].img, blockArray[i].x, blockArray[i].y, blockArray[i].width, blockArray[i].height);
            }
        }

        function update() {
            if (gameOver) return;

            moveBall();
            checkCollision(); // 볼과 벽,블럭,보드와의 충돌검사
            moveBoard();
        }

        function moveBall() {
            ball.x += ball.dirX * ball.moveSpeed;
            ball.y += ball.dirY * ball.moveSpeed;
            setPosition(ball, ball.x, ball.y);
        }

        function moveBoard() {

            if (isXCollision == true) return;
            if (leftKeyPressed) board.x -= 5;
            if (rightKeyPressed) board.x += 5;

            if (board.x < 0) // 왼쪽 벽 충돌
            {
                board.x = 0;
            } else if (board.x > canvas.width - board.width) // 100은 paddle의 가로 길이
            {
                board.x = canvas.width - board.width;
            }
            setPosition(board, board.x, board.y);
        }

        function checkCollision() {
            checkBallWall();
            checkBallBoard();
            checkBallBlock();
        }

        function checkBallWall() {
            // ball wall
            if (ball.x < 0) { // 서쪽벽 충돌
                ball.x = 0;
                setPosition(ball.x, ball.y);
                ball.dirX *= -1;
            }
            if (ball.x > canvas.width - ball.width) // 동쪽벽 충돌
            {
                ball.x = canvas.width - ball.width;
                setPosition(ball.x, ball.y);
                ball.dirX *= -1;
            }
            if (ball.y < 0) // 북쪽벽 충돌
            {
                ball.y = 0;
                setPosition(ball, ball.x, ball.y);
                ball.dirY *= -1;
            }
            if (ball.bottom > canvas.height) // 남쪽 벽 충돌
            {
                ballDied();
            }
        }

        function ballDied() {
            if (life == 0) {
                gameOver = true;
                alert("GAME OVER");
                location.href = "arka_process.jsp?score="+score;
                
                return;
            }

            life--;

            ball.x = 400;
            ball.y = 400;
            ball.width = 20;
            ball.height = 20;
            setPosition(ball, ball.x, ball.y);
            ball.dirX = 0; // 1과-1의 사잇값만 갖는 방향벡터 direction vector
            ball.dirY = -1;
        }

        function checkBallBoard() {
            // ball board
            if (intersectRect(ball, board)) {
                var type1 = getCollisionDirection(ball, board);

                switch (type1) {
                    case 0: // y축 충돌
                        ball.dirY *= -1;

                        // board의 상대적 x값에 의해
                        var diff = (ball.x + ball.width / 2) - (board.x + board.width / 2);
                        // 중앙으로 갈수록 0에 가까움 
                        // 오른쪽으로 갈 수록 +값
                        // 왼쪽으로 갈 수록 -값 -50 < diff < +50           
                        diff = Math.floor(diff);
                        console.log(diff);
                        if (-60 <= diff && diff <= -30) {
                            ball.dirX = -0.86;
                            ball.dirY = -0.5;
                        } else if (-30 < diff && diff <= -10) {
                            ball.dirX = -0.7;
                            ball.dirY = -0.7;
                        } else if (-10 < diff && diff <= 10) {
                            ball.dirX = 0;
                            ball.dirY = -1;
                        } else if (10 < diff && diff <= 30) {
                            ball.dirX = 0.7;
                            ball.dirY = -0.7;
                        } else if (30 < diff && diff <= 60) {
                            ball.dirX = 0.86;
                            ball.dirY = -0.5;
                        }

                        break;
                    case 1: // x축 충돌
                        isXCollision = true;
                        if (ball.x < board.x) {
                            ball.dirX = -0.86;
                            ball.dirY = -0.5;
                        } else {
                            ball.dirX = 0.86;
                            ball.dirY = -0.5;
                        }
                        break;
                }
            } else isXCollision = false;
        }

        function checkBallBlock() {
            // ball & block
            if( unableCount == 6 * 15 ) 
            {
            	location.href = "arka_process.jsp?score="+score;
                alert("GAME CLEAR!");
                gameOver = true;
            }
            for (var i = 0; i < 6 * 15; i++) {
                if (!blockArray[i].isAble) continue;
                if (intersectRect(ball, blockArray[i])) {
                    var type = getCollisionDirection(ball, blockArray[i]);

                    switch (type) {
                        case 0: // y축 충돌
                            ball.dirY *= -1;
                            blockArray[i].isAble = false;
                            unableCount++;
                            break;
                        case 1: // x축 충돌
                            ball.dirX *= -1;
                            blockArray[i].isAble = false;
                            unableCount++;
                            break;
                    }
                    score++;
                    if (ball.moveSpeed < 4) {     // 블럭이 충돌할때마다 Ball의 스피드 2.9까지 상승
                        ball.moveSpeed += 0.1;
                    }

                    break;
                }
            }
        }

        function getCollisionDirection(r1, r2) {
            // width와 height는 충돌하는 두 rect가 공유하는 rect의 width와 height
            var height = 0;
            var width = 0;

            // rect의 위치에 따라 width와 height를 양수로 만들기 위한 작업
            if (r1.y > r2.y) height = r2.bottom - r1.top;
            else height = r1.bottom - r2.top;
            if (r1.x > r2.x) width = r2.right - r1.left;
            else width = r1.right - r2.left;

            if (width > height) return 0; // y축 충돌
            else return 1; // x축 충돌
        }

        function KeyDownHandler(e) {
            switch (e.key) {

                case 'ArrowLeft':
                    leftKeyPressed = true;
                    break;
                case 'ArrowRight':
                    rightKeyPressed = true;
                    break;

                default:
                    break;
            }
        }

        function KeyUpHandler(e) {
            switch (e.key) {
                case 'ArrowLeft':
                    leftKeyPressed = false;
                    break;
                case 'ArrowRight':
                    rightKeyPressed = false;
                    break;

                default:
                    break;
            }
        }

        // r1 r2가 충돌했다면 true를 리턴
        function intersectRect(r1, r2) {    
            if (r1.right < r2.left || r2.right < r1.left || r2.top > r1.bottom || r2.bottom < r1.top) {
                return false;
            } else return true;
        }

        function setPosition(obj, x, y) {
            obj.x = x;
            obj.y = y;

            obj.left = obj.x;
            obj.right = obj.x + obj.width;
            obj.top = obj.y;
            obj.bottom = obj.y + obj.height;
        }
    </script>

    <style>
        canvas {
            background-image: url('images/space.png');
            border: 1px solid black;
            padding-left: 0;
            padding-right: 0;
            margin-left: auto;
            margin-right: auto;
            display: block;
            width: 800px;
        }
        
        #imgrsc {
            display: none;
        }
    </style>

</head>

<body onload="initTitleScene();">   <!-- 타이틀씬의 이닛함수 실행-->
    <canvas id="alka" width="800" height="600"></canvas>
    <div id="imgrsc">
        <img id="board" src="images/paddle.png">
        <img id="block1" src="images/block1.png">
        <img id="block2" src="images/block2.jpg">
        <img id="ball" src="images/ball2.png">
        <img id="titleLogo" src="images/titlelogo.png">
        <img id="play" src="images/play.jpg">
    </div>
</body>

</html>