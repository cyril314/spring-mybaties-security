<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<c:set var="ctx" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <!--360浏览器优先以webkit内核解析-->
    <title>后台首页</title>
    <link rel="stylesheet" type="text/css" href="${ctx}/static/plugins/calendar/css/simple-calendar.css" />
    <script type="text/javascript" src="${ctx}/static/js/jquery.min.js?v=2.1.4"></script>
    <script type="text/javascript" src="${ctx}/static/plugins/calendar/js/simple-calendar.js"></script>
</head>
<body class="gray-bg">
<div id='container' style="margin: 0 0 0 50px;box-shadow:none;"></div>
</body>
<script>
    //日历
    var options = {
        width: '800px',
        height: '600px',
        language: 'CH', //语言
        showLunarCalendar: true, //阴历
        showHoliday: true, //休假
        showFestival: true, //节日
        showLunarFestival: true, //农历节日
        showSolarTerm: true, //节气
        showMark: true, //标记
        timeRange: {
            startYear: 1900,
            endYear: 2049
        },
        mark: {
            '2016-5-5': '上学'
        },
        theme: {
            changeAble: true,
            weeks: {
                backgroundColor: '#FBEC9C',
                fontColor: '#4A4A4A',
                fontSize: '30px',
            },
            days: {
                backgroundColor: '#ffffff',
                fontColor: '#565555',
                fontSize: '34px'
            },
            todaycolor: 'orange',
            activeSelectColor: 'orange',
        }
    }

    $(function(){
        var myCalendar = new SimpleCalendar('#container',options);
    });

</script>
</html>
