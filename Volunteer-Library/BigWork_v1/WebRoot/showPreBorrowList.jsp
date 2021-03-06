<%@ page language="java" import="java.util.*, bean.Book, bean.BorrowBook, bean.Account" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%-- 这坑爹货 --%>
<%@ page isELIgnored="false" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html lang="en">
  <head>

        <!-- meta data & title -->
        <meta charset="utf-8">
        <title>Office</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta name="description" content="">
        <meta name="author" content="">

        <!-- Favicon and touch icons -->
        <link rel="shortcut icon" href="assets/ico/favicon.ico">
        <link rel="apple-touch-icon-precomposed" sizes="144x144" href="assets/ico/apple-touch-icon-144-precomposed.png">
        <link rel="apple-touch-icon-precomposed" sizes="114x114" href="assets/ico/apple-touch-icon-114-precomposed.png">
        <link rel="apple-touch-icon-precomposed" sizes="72x72" href="assets/ico/apple-touch-icon-72-precomposed.png">
        <link rel="apple-touch-icon-precomposed" href="assets/ico/apple-touch-icon-57-precomposed.png">

	    <!-- CSS -->
	    <link rel="stylesheet" href="http://fonts.googleapis.com/css?family=Open+Sans:400,300">
	    <link href='http://fonts.googleapis.com/css?family=PT+Sans' rel='stylesheet' type='text/css'>
	    <link href="http://fonts.googleapis.com/css?family=Raleway" rel="stylesheet" type="text/css">
	    <link rel="stylesheet" href="assets/bootstrap/css/bootstrap.css">
	    <link rel="stylesheet" href="assets/css/font-awesome.min.css">
	    <link rel="stylesheet" href="assets/css/animate.min.css">
	    <link rel="stylesheet" href="assets/css/style.css">
	    <link rel="stylesheet" href="assets/css/list.css">
	    <link href="login-register.css" rel="stylesheet" />
	    <link rel="stylesheet" href="http://netdna.bootstrapcdn.com/font-awesome/4.0.3/css/font-awesome.css">
		
		<!-- JS -->
		<script src="jquery/jquery-1.10.2.js" type="text/javascript"></script>
		<script src="bootstrap3/js/bootstrap.js" type="text/javascript"></script>
		<script src="login-register.js" type="text/javascript"></script>
		<script src="js/register_check.js" type="text/javascript"></script>
		<script src="js/login_again.js" type="text/javascript"></script>
		<script src="js/outputCookie.js" type="text/javascript"></script>
		<script src="js/booklist_control.js" type="text/javascript"></script>
        
        
    </head>
<% 
 String user_na = "";
 String user_ty = "";
 if(session.getAttribute("account")==null)
 {
	 out.println("<script>alert('请先进行登录');location.href='index.jsp'</script>");
 }   
 else 
 {
	 user_na = ((Account)session.getAttribute("account")).getUser_name();
	 user_ty = ((Account)session.getAttribute("account")).getType();
 }
%>
    <!-- Header -->
   	<body>
  	<nav id="navbar-section" class="navbar navbar-default navbar-static-top navbar-sticky" role="navigation">
        <div class="container">
        
            <div class="navbar-header">
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-responsive-collapse">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>

                <a class="navbar-brand wow fadeInDownBig" href="index.jsp"><img class="office-logo" src="assets/img/slider/Office.png" alt="Office"></a>      
            </div>
        
            <div id="navbar-spy" class="collapse navbar-collapse navbar-responsive-collapse">
                <ul class="nav navbar-nav pull-right">
                    <li>
                        <a href="index_login.jsp">主页</a>
                    </li>
                    <li>
                        <a href="about.html">关于</a>
                    </li>
                    <li class="active">
                        <a data-toggle="modal" href="ordinary_message.jsp"><%=user_na %> 的个人信息</a>
                    </li>
                    <li>
                        <a href="LogoutServlet">注销</a>
                    </li>
                </ul>         
            </div>
        </div>
    </nav>
  

    
	<div class="container">
      <div class="row" >
		<br>
		<br>
		<br>
		<br>
		<br>
		<br>
        <div id="navbar-spy" class="col-sm-2">
            <ul class="nav nav-pills nav-stacked">
            <li><a href="ordinary_message.jsp">个人信息</a></li>
            <li class="active"><a href="showPreBorrowList.jsp">我的预借清单</a></li>
            <li><a href="BorrowMessage">借书情况</a></li>
            <li><a href="DonateMessage">捐书情况</a></li>
            <% 
            	if(user_ty!=null && user_ty.equals("ordinary")){
            		out.print("<li><a href=\"message_board.jsp\">留言板</a></li>");
            	}
            	if(user_ty!=null && user_ty.equals("volunteer")){
            		out.print("<li><a href=\"message_board.jsp\">留言板</a></li>");
            		out.print("<li><a href=\"volwork.jsp\">我的工作</a></li>");
            	}
            	if(user_ty!=null && user_ty.equals("manager")){
            		out.print("<li><a href=\"MessageCheck\">留言板查看</a></li>");
            		out.print("<li><a href=\"UserServlet\">人员管理</a></li>");
            		out.print("<li><a href=\"BorrowExamine\">借书审核</a></li>");
            		out.print("<li><a href=\"DonateExamine\">捐书审核</a></li>");
            	}
             %>
            </ul>
        </div>
      
    
	<table align="center" width="80%" border="0" cellspacing="0" cellpadding="0">
     <h3 class="biaoti" colspan="3" align="center" height="60" >我的预借清单</h3>
	    	 <br>
	    	<tr>
         		<th style="text-align:center;" class="btbg font-center titfont">书号</th>
	    		<th style="text-align:center;" class="btbg font-center titfont">书名</th>
	    		<th style="text-align:center;" class="btbg font-center titfont">作者</th>
	    		<th style="text-align:center;" class="btbg font-center titfont">借阅数目</th>
	    		<th style="text-align:center;" class="btbg font-center titfont">删除</th>
	    	</tr>
           	
	    	<%
	    		Map<String, BorrowBook> borrowmap = (HashMap<String, BorrowBook>)session.getAttribute("borrowmap");
	    		if(borrowmap!=null){
	    		
		    		for (Map.Entry<String, BorrowBook> entry : borrowmap.entrySet()) {
	   					BorrowBook borrowbook = entry.getValue();
	   					out.print("<tr>");
	   					out.print("<td align=\"center\" style=\"width:10%\" class=\"btbg font-center\">"+borrowbook.getBorrow_id()+"</td>");
	   					out.print("<td align=\"center\" style=\"width:10%\" class=\"btbg font-center\">"+borrowbook.getBorrow_book_name()+"</td>");
	   					out.print("<td align=\"center\" style=\"width:10%\" class=\"btbg font-center\">"+borrowbook.getBorrow_book_author()+"</td>");
	   					out.print("<td align=\"center\" style=\"width:10%\" class=\"btbg font-center\">"+borrowbook.getBorrow_book_num()+"</td>");
	   					out.print("<td align=\"center\" style=\"width:10%\" class=\"btbg font-center\"><a href=\"UpdatePreBorrowList?id=");
	   					out.print(borrowbook.getBorrow_id());
	   					out.print("&num=");
	   					out.print(borrowbook.getBorrow_book_num());
	   					out.print("\">删除</a></td>");
	   					out.print("</tr>");
	  				}
	  			}
	    	 %>
	    	 
    	</table>
	    	 <br>
    	<table align="center">
    	<tr align="center">
            <td align="center" class="btn"><a href="BookListServlet?op=1">返回继续添加</a></td>
            <td style="width:20%"></td>
            <td align="center" class="btn"><a href="RealBorrowServlet">提交借阅申请</a></td>
        </tr>
    	</table>
	
   </div>
   </div>
	
<!-- Footer -->
    <footer> 
        <div class="container">
            <div class="row">
                <div class="col-md-4">
                    <h3><i class="fa fa-map-marker"></i> 联系我们:</h3>
                    <p class="footer-contact">
                        深圳大学石头坞二楼义工联合会办公室<br>
                        电话: 13811467407<br>
                        邮箱: jryg@163.com<br>
                    </p>
                </div>
                <div class="col-md-4">
                    <h3><i class="fa fa-external-link"></i> 链接</h3>
                    <p> <a href="#"> 关于我们 </a></p>
                    <p> <a href="#"> 留言箱</a></p>
                    <p> <a href="#"> 了解更多</a></p>
                </div>
              <div class="col-md-4">
                <h3><i class="fa fa-heart"></i> 社交</h3>
                <div id="social-icons">
                    <a href="#" class="btn-group google-plus">
                        <i class="fa fa-weixin"></i>
                    </a>
                      <a href="#" class="btn-group linkedin">
                        <i class="fa fa-qq"></i>
                    </a>
                      <a href="#" class="btn-group twitter">
                        <i class="fa fa-weibo"></i>
                    </a>
                      <a href="#" class="btn-group facebook">
                        <i class="fa fa-facebook"></i>
                    </a>
                </div>
              </div>    
        </div>
      </div>
    </footer>

    
    <script type="text/javascript" src="js/jquery-1.10.2.min.js"></script>
    <script src="assets/bootstrap/js/bootstrap.min.js"></script>
    <script src="js/wow.min.js"></script>
    <script>
      new WOW().init();
    </script>
	</body>
</html>
