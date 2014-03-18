<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false" %>
<button id="addSystemConfig">Add</button>
<button id="deleteSystemConfig">Delete</button>
<button id="refreshSystemConfig">Refresh</button>
<div id="systemConfigDiv" title=""></div>

<script type="text/javascript">
$(document).ready(function(){
	var table=$.ajax({url:"common/querySystemConfig.action",async:false});
	$("#systemConfigDiv").html(table.responseText);
});

$(function() 
{
    $( "#addSystemConfig" )
        .click(function( event ) {
            alert(1);
        });
});
</script>
