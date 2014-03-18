<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ include file="/WEB-INF/jsp/common/TGKSHeaderList.inc.jsp" %>
<div id="customTableDiv" class="ui-widget">
    <table id="customTable" class="ui-widget ui-widget-content">
        <thead>
            <tr class="ui-widget-header ">
                <th style="width:20;"><input type="checkbox" id="allCustomId" name="allCustomId"/></th>
				<th>名称</th>
				<th>电话</th>
				<th>传真</th>
				<th>地址</th>
				<th>备注</th>
            </tr>
        </thead>
        <tbody>
			<s:iterator  value="list" var="evt">
				<tr>
					<td style="width:20;"><input type="checkbox" name="customId" value="<s:property value='#evt.id'/>"/></td>
					<td><b id="<s:property value='#evt.id'/>" class="customUpdate"><s:property value="#evt.name"/></b></td>
					<td><s:property value="#evt.tel"/></td>
					<td><s:property value="#evt.fax"/></td>
					<td><s:property value="#evt.address"/></td>
					<td><s:property value="#evt.remark"/></td>
				</tr>
			</s:iterator>
		</tbody>
    </table>
</div>
<script type="text/javascript">
	$(function() {
		$("#customTable").longtable({
			'perPage' : 8
		});

		// 点击记录首栏进入更新操作
		$(".customUpdate").click(function() {
			$("#customEdit").dialog("open");
			var edit = $.ajax({
				url : "../wms/editCustomPage.action?id=" + this.id,
				async : false
			});
			$("#customForm").html(edit.responseText);
		});

		// 全选
		$("#allCustomId").click(function() {
			var checkbox = $("#customTable :checkbox");
			for ( var i = 1; i < checkbox.length; i++) {
				if (checkbox[i].hidden == "") {
					checkbox[i].checked = checkbox[0].checked;
				}
			}
		});
	});
</script>
