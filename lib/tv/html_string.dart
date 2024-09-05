String getHtmlString(String ipAddress) => '''
<!DOCTYPE html>
<html lang="zh_CN">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>极简TV</title>
    <style>
        body {
            padding: 20px;
            background-color: #f0f0f0;
            background-image: url('https://fastly.jsdelivr.net/gh/aiyakuaile/images/idiom_bg_6.jpg');
            background-size: cover;
            background-position: center;
            background-repeat: no-repeat;
            height: 100vh;
        }
        h2 {
            color: #333;
        }
        label {
            display: block;
            margin-bottom: 8px;
            color: #666;
        }
        textarea {
            width: 100%;
            min-height: 100px;
            padding: 10px;
            font-size: 16px;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
            transition: border-color 0.3s ease;
            resize: vertical; /* 允许垂直调整 */
        }
        textarea:focus {
            border-color: #007bff;
            outline: none;
        }
        button {
            padding: 12px 20px;
            background-color: #007bff;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            font-size: 16px;
            transition: background-color 0.3s ease;
        }
        button:hover {
            background-color: #0056b3;
        }
    </style>
<script>
        function autoResize(element) {
            element.style.height = "auto";
            element.style.height = (element.scrollHeight) + "px";
        }
    function sendPostRequest() {
        var userInput = document.getElementById("userInput").value;
        var url = "$ipAddress"; 
        var data = { url: userInput };
        fetch(url, {
            method: "POST",
            headers: {
                "Content-Type": "application/json"
            },
            body: JSON.stringify(data)
        })
        .then(response => {
            if (!response.ok) {
                throw new Error('Network response was not ok');
            }
            return response.json();
        })
        .then(data => {
            alert(data.message);
        })
        .catch(error => {
            alert(error.message);
        });
    }
</script>
</head>
<body>
    <h2>添加订阅源</h2>
    <textarea id="userInput" placeholder="请输入订阅源" oninput="autoResize(this)"></textarea>
    <br><br>
    <button onclick="sendPostRequest()">立即推送</button>
</body>
</html>
''';
