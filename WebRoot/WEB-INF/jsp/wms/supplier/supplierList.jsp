<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<%@ include file="/WEB-INF/jsp/common/TGKSHeaderList.inc.jsp" %>
<div id="supplierTableDiv" class="ui-widget">
    <table id="supplierTable" class="ui-widget ui-widget-content">
        <thead>
            <tr class="ui-widget-header ">
                <th style="width:20;"><input type="checkbox" id="allSupplierId" name="allSupplierId"/></th>
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
					<td style="width:20;"><input type="checkbox" name="supplierId" value="<s:property value='#evt.id'/>"/></td>
					<td><b id="<s:property value='#evt.id'/>" class="supplierUpdate"><s:property value="#evt.name"/></b></td>
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
		$("#supplierTable").longtable({
			'perPage' : 8
		});

		// 点击记录首栏进入更新操作
		$(".supplierUpdate").click(function() {
			$("#supplierEdit").dialog("open");
			var edit = $.ajax({
				url : "../wms/editSupplierPage.action?id=" + this.id,
				async : false
			});
			$("#supplierForm").html(edit.responseText);
		});

		// 全选
		$("#allSupplierId").click(function() {
			var checkbox = $("#supplierTable :checkbox");
			for ( var i = 1; i < checkbox.length; i++) {
				if (checkbox[i].hidden == "") {
					checkbox[i].checked = checkbox[0].checked;
				}
			}
		});
	});
</script>
