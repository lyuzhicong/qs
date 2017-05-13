<!DOCTYPE html>
<html lang="en">
<link href="css/web/reset.css" rel="stylesheet" type="text/css" />
<link href="css/web/media.css" rel="stylesheet" type="text/css" />
<link href="css/web/main.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="http://apps.bdimg.com/libs/jquery/2.1.4/jquery.min.js"></script>

<head>
    <meta charset="utf-8">
    <title>青松基金</title>
</head>

<body>
    <header>
        <div class="header">
            <div class="logo">
                <img src="images/web/logo.png">

            </div>
            <nav>
                <ul class="nav">
                    <li><a href="index.html">首页</a></li>
                    <li><a href="group.html">投资组合</a></li>
                    <li><a href="team.html">投资团队</a></li>
                    <li><a href="share.jsp">青松分享</a></li>
                    <li><a href="about.html">关于青松</a></li>
                </ul>
            </nav>
        </div>

    </header>
    <main class="share-wrap">
        <div class="share">
            <div class="share-detail">
                <span>
                青松分享
            </span>
                <ul>
                    <li>
                        <img src="images/web/刘晓松.jpg">
                        <div>
                            <h4>
                                刘晓松：社交网络在这6个方向上还有机会！最大机会是孩子绝不愿和爹妈用同一个产品！
                            </h4>
                            <span>
                            2017.02.27
                        </span>
                        </div>
                    </li>
                    <li>
                        <img src="images/web/刘晓松.jpg">
                        <div>
                            <h4>
                                刘晓松：社交网络在这6个方向上还有机会！最大机会是孩子绝不愿和爹妈用同一个产品！
                            </h4>
                            <span>
                            2017.02.27
                        </span>
                        </div>
                    </li>
                    <li>
                        <img src="images/web/刘晓松.jpg">
                        <div>
                            <h4>
                                刘晓松：社交网络在这6个方向上还有机会！最大机会是孩子绝不愿和爹妈用同一个产品！
                            </h4>
                            <span>
                            2017.02.27
                        </span>
                        </div>
                    </li>
                    <li>
                        <img src="images/web/刘晓松.jpg">
                        <div>
                            <h4>
                                刘晓松：社交网络在这6个方向上还有机会！最大机会是孩子绝不愿和爹妈用同一个产品！
                            </h4>
                            <span>
                            2017.02.27
                        </span>
                        </div>
                    </li>
                    <li>
                        <img src="images/web/刘晓松.jpg">
                        <div>
                            <h4>
                                刘晓松：社交网络在这6个方向上还有机会！最大机会是孩子绝不愿和爹妈用同一个产品！
                            </h4>
                            <span>
                            2017.02.27
                        </span>
                        </div>
                    </li>
                </ul>
            </div>
            <div class="share-list">
                <span>
                TA们说
            </span>
                <ul>
                    <li>
                        <h4>一花科技CEO 张伟文:</h4>
                        <p>投资效率高，青松的风格是帮忙不添乱，如果再来一次，我还是会选择青松。</p>
                        <img src="images/web/ceo/1一花科技.jpg">
                    </li>
                    <li>
                        <h4>哒哒英语CEO 郅慧:</h4>
                        <p>青松基金是创业者的引路人，牵手青松是创业路上最幸运的事之一</p>
                        <img src="images/web/ceo/2哒哒英语.jpg">
                    </li>
                    <li>
                        <h4>睿悦CEO 赖俊菘:</h4>
                        <p>感谢青松的陪伴，有了你，我们往前奔跑的更踏实。</p>
                        <img src="images/web/ceo/3nibiru.jpg">
                    </li>
                    <li>
                        <h4>小恒水饺CEO 李恒:</h4>
                        <p>青松是最懂创业者的基金！</p>
                        <img src="images/web/ceo/4小恒水饺-.jpg">
                    </li>
                    <li>
                        <h4>掌门1v1CEO 张翼:</h4>
                        <p>青松是一个有速度、有温度、有深度的大家庭，褪去创业者身上的孤独感，坚实有力，催人奋进！</p>
                        <img src="images/web/ceo/6掌门.jpg">
                    </li>
                    <li>
                        <h4>欢乐互娱CEO 时继江:</h4>
                        <p>青松基金是创业者的引路人，牵手青松是创业路上最幸运的事之一</p>
                        <img src="images/web/ceo/8欢乐互娱.jpg">
                    </li>

                    <li>
                        <h4>彩球CEO 雷雨田:</h4>
                        <p>感谢青松基金，让我在创业路上快速成长，记得我们从见面谈项目到打款只用了一周时间，青松基金是中国最棒的，最专业“快投”天使。</p>
                        <img src="images/web/ceo/15彩球.jpg">
                    </li>

                </ul>
                <div>
                    <button id="back">back</button>
                    <button id="next">next</button>
                </div>
            </div>

        </div>
    </main>
    <footer>
        <div class="footer">
            <small>© 2012 QingSong Fund All rights reserved. 粤ICP备12034380号</small>
            <span>
            <img src="images/web/pic_QR_code.png" id="wechatcode">
            <img src="images/web/icon_wechat_normal.png" id="wechat">
        </span>
        </div>

    </footer>
</body>
<script type="text/javascript" src="js/main.js"></script>
<script type="text/javascript">
    $(function() {
        var count = 1;
        $(".share-list ul li").hide();
        $(".share-list ul li:first").show();

        $("#next").click(function() {
            count++;
            $(".share-list ul li").hide();
            $(".share-list ul li:nth-child(" + count + ")").fadeIn("fast");

        })

        $("#back").click(function() {
            count--;
            $(".share-list ul li").hide();
            $(".share-list ul li:nth-child(" + count + ")").fadeIn("fast");

        })
    })
</script>

</html>