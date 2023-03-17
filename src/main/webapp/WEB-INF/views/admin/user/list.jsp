<%@page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>用户列表</title>
    <jsp:include page="../../_include/head.jsp"/>
</head>
<body class="gray-bg">
<div class="wrapper wrapper-content animated fadeInRight">
    <div class="ibox float-e-margins">
        <div class="col-sm-12">
            <!-- Example Events -->
            <div class="example-wrap">
                <div class="btn-group hidden-xs" id="exampleTableEventsToolbar" role="group">
                    <button type="button" class="btn btn-outline btn-default" id="addUser">
                        <i class="glyphicon glyphicon-plus" aria-hidden="true"></i>
                    </button>
                    <button type="button" class="btn btn-outline btn-default" id="editUser">
                        <i class="glyphicon glyphicon-edit" aria-hidden="true"></i>
                    </button>
                    <button type="button" class="btn btn-outline btn-default" id="delUser">
                        <i class="glyphicon glyphicon-trash" aria-hidden="true"></i>
                    </button>
                </div>
                <table id="exampleTableEvents" data-height="400" data-mobile-responsive="true">
                    <thead>
                    <tr>
                        <th data-field="state" data-checkbox="true"></th>
                        <th data-field="id">ID</th>
                        <th data-field="creatdate">创建时间</th>
                        <th data-field="username">用户名</th>
                        <th data-field="name">昵称</th>
                        <th data-field="desc">详情</th>
                    </tr>
                    </thead>
                </table>
            </div>
            <!-- End Example Events -->
        </div>
    </div>
</div>
<jsp:include page="../../_include/foot.jsp"/>
<script type="text/javascript">
    $(document).ready(function () {
        //先销毁表格
        $('#exampleTableEvents').bootstrapTable('destroy');
        //初始化表格,动态从服务器加载数据
        $('#exampleTableEvents').bootstrapTable({
            method: 'post',
            url: "/sysuser/list",
            dataType: "json",
            search: true,
            pagination: true,
            showRefresh: true,
            showToggle: true,
            showColumns: true,
            iconSize: 'outline',
            toolbar: '#exampleTableEventsToolbar',
            icons: {
                refresh: 'glyphicon-repeat',
                toggle: 'glyphicon-list-alt',
                columns: 'glyphicon-list'
            },
            onLoadSuccess: function () {  //加载成功时执行
                layer.msg("加载成功");
            },
            onLoadError: function () {  //加载失败时执行
                layer.msg("加载数据失败", {time: 1500, icon: 2});
            }
        });

        $('#addUser').click(function () {
            var index = layer.open({
                type: 2,
                title: '编辑用户',
                area: ['50%', '75%'],
                skin: 'layui-layer-rim', //加上边框
                content: ['/sysuser/edit', 'yes']

            });
            //layer.full(index);
        });

        $('#editUser').click(function () {
            var rows = $('#exampleTableEvents').bootstrapTable('getSelections');
            if (rows.length == 0) {
                layer.msg("请先选中表格中的某一记录!", {time: 1500, icon: 2});
            } else if (rows.length == 1) {
                var id = rows[0].id;
                var index = layer.open({
                    type: 2,
                    title: '编辑用户',
                    area: ['50%', '75%'],
                    skin: 'layui-layer-rim', //加上边框
                    content: ['/sysuser/edit?id=' + id, 'yes']

                });
            } else {
                layer.msg("只能选择一个进行编辑", {time: 1500, icon: 2});
            }
            //layer.full(index);
        });

        $('#delUser').click(function () {
            var rows = $('#exampleTableEvents').bootstrapTable('getSelections');
            if (rows.length == 0) {
                layer.confirm('您确定删除么?', {
                    btn: ['确定', '取消'] //按钮
                }, function () {
                    layer.msg('的确很重要', {icon: 1});
                }, function (index) {
                    layer.close(index)
                });
            } else {
                layer.confirm('您确定删除么?', {
                    btn: ['确定', '取消'] //按钮
                }, function () {
                    var ids = new Array();
                    for (var i in rows) {
                        ids.push(rows[i].id);
                    }
                    $.post("/sysuser/delete", {id: ids.toString()}, function (data) {
                        console.log(data);
                        if (data.code == "200") {
                            layer.msg(data.msg);
                            $('#exampleTableEvents').bootstrapTable('refresh', "/admin/list");
                        } else {
                            layer.msg(data.msg, {time: 1500, icon: 2});
                        }
                    }, "json");
                }, function (index) {
                    layer.close(index)
                });
            }
        });
    });
    
    function userTableRefresh() {
        $('#exampleTableEvents').bootstrapTable('refresh', "/sysuser/list");
    }
</script>
</body>
</html>