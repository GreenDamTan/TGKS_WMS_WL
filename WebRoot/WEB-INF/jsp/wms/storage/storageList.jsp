<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ include file="/WEB-INF/jsp/common/TGKSHeaderList.inc.jsp" %>
<input type="hidden" id="storageListSubmit" name="storageListSubmit" value="0" />
<div id="storageTableDiv" class="ui-widget">
    <table id="storageTable" class="ui-widget ui-widget-content">
        <thead>
            <tr class="ui-widget-header ">
                <th width="20"><input type="checkbox" id="allStorageId" name="allStorageId"/></th>
				<th>名称</th>
				<th>编号</th>
				<th>类别</th>
				<th>材料</th>
				<th>型号</th>
				<th>规格</th>
				<th>入库数量</th>
				<th>单位</th>
				<th>单价</th>
				<th>供应商</th>
				<th>入库时间</th>
				<!-- <th>打印状态</th> -->
				<th>备注</th>
				<th>操作</th>
            </tr>
        </thead>
        <tbody>
			<s:iterator  value="list" var="evt">
				<tr>
					<td width="20"><input type="checkbox" name="storageId" value="<s:property value='#evt.id'/>"/></td>
					<td><s:property value="#evt.name"/></td>
					<td><s:property value="#evt.code"/></td>
					<td><s:if test="#evt.type == 0">原材料</s:if><s:if test="#evt.type == 1">半成品</s:if><s:if test="#evt.type == 2">成品</s:if></td>
					<td><s:property value="#evt.material"/></td>
					<td><s:property value="#evt.model"/></td>
					<td><s:property value="#evt.spec"/></td>
					<td><s:property value="#evt.number"/></td>
					<td><s:property value="#evt.unit"/></td>
					<td><s:property value="#evt.price"/></td>
					<td><s:property value="#evt.supplier"/></td>
					<td><s:date name="#evt.createTime" format="yyyy-MM-dd HH:mm:ss"/></td>
					<!-- <td><s:if test="#evt.print == 0">未打印</s:if><s:if test="#evt.print == 1">已打印</s:if></td> -->
					<td><s:property value="#evt.remark"/></td>
					<td><button id="<s:property value='#evt.id'/>" class="cancelStorage">取消入库</button></td>
				</tr>
			</s:iterator>
		</tbody>
    </table>
</div>

<div id="cancelStorageConfirm" title="操作确认" hidden="hidden">
	<p><span class="ui-icon ui-icon-alert" style="float: left; margin: 0 7px 20px 0;"></span>取消入库将会从库存中扣除入库数量，是否确认？</p>
</div>
<script type="text/javascript">
	$(function() {
		$('#storageTable').longtable({
			'perPage' : 10
		});
		
		function query()
		{
			var table=$.ajax({url:"../wms/queryStorage.action", data:$("#storageReq").formSerialize(), async:false});
			$("#storageDiv").html(table.responseText);
		}
		
		// 取消入库按钮
		$( ".cancelStorage" ).button().click(function() {
			// ajax调用删除action
			var options = { 
				url:"../wms/cancelStorage.action?id=" + this.id , // 提交给哪个执行
				type:'POST', 
				success: function(){
					alert("操作成功");
					// 执行成功刷新form
					query();
				},
				error:function(){ 
					alert("操作失败"); 
				}
			};
			
			// 确认操作
			$("#cancelStorageConfirm").dialog({
				resizable: false,
	            height:160,
	            modal: true,
	            buttons: {
	                "确认": function() {
	                	$( this ).dialog( "close" );
	                	// 异步请求删除操作
	                	$("#cancelStorageConfirm").ajaxSubmit(options);
	                },
	                "取消": function() {
	                    $( this ).dialog( "close" );
	                }
	            }
			});
					
			return false;
		});

		/* 点击记录首栏进入更新操作
		$(".storageUpdate").click(function() {
			$("#storageEdit").dialog("open");
			var edit = $.ajax({
				url : "../wms/editStoragePage.action?id=" + this.id,
				async : false
			});
			$("#storageForm").html(edit.responseText);
		});
		*/

		// 全选
		$("#allStorageId").click(function() {
			var checkbox = $("#storageTable :checkbox");
			for ( var i = 1; i < checkbox.length; i++) {
				if (checkbox[i].hidden == "") {
					checkbox[i].checked = checkbox[0].checked;
				}
			}
		});
	});
</script>
