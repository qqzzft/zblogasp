    </div>
  </div>
</div>

			</div>
<script type="text/javascript">
// <![CDATA[


function bmx2table(){

	//斑马线
	var tables=document.getElementsByTagName("table");
	for (var j = 0; j < tables.length; j++){

		var cells = tables[j].getElementsByTagName("tr");
		var b=false;
		cells[0].className="color1";
		for (var i = 1; i < cells.length; i++){
			if(b){
				cells[i].className="color2";
				b=false;
				cells[i].onmouseover=function(){
					this.className="color4";
				}
				cells[i].onmouseout=function(){
					this.className="color2";
				}
			}
			else{
				cells[i].className="color3";
				b=true;
				cells[i].onmouseover=function(){
					this.className="color4";
				}
				cells[i].onmouseout=function(){
					this.className="color3";
				}
			};
		};
	};
};


function changeCheckValue(obj){

	$(obj).toggleClass('imgcheck-on');

	if($(obj).hasClass('imgcheck-on')){
		$(obj).prev('input').val('True');
	}else{
		$(obj).prev('input').val('False');
	}

}

    // Content box tabs:
		
	$('.content-box .content-box-content div.tab-content').hide(); // Hide the content divs
	$('ul.content-box-tabs li a.default-tab').addClass('current'); // Add the class "current" to the default tab
	$('.content-box-content div.default-tab').show(); // Show the div with class "default-tab"
	
	$('.content-box ul.content-box-tabs li a').click( // When a tab is clicked...
		function() { 
			$(this).parent().siblings().find("a").removeClass('current'); // Remove "current" class from all tabs
			$(this).addClass('current'); // Add class "current" to clicked tab
			var currentTab = $(this).attr('href'); // Set variable "currentTab" to the value of href of clicked tab
			$(currentTab).siblings().hide(); // Hide all content divs
			$(currentTab).show(); // Show the content div with the id equal to the id of clicked tab
			return false; 
		}
	);



$(document).ready(function(){ 

	bmx2table();

	//if($('.SubMenu').find('span').length==0){$('.SubMenu').hide()};
	/*if($('.SubMenu').find('span').length>0){
		if($('#leftmenu').find('li.on').length>0){
			$('#leftmenu li.on').after('<li class="sub">'+$('.SubMenu').html()+'</li>');
		}else{
			$('.SubMenu').show();
		}
	}*/

	//$("#avatar").attr("src","<%="http://www.gravatar.com/avatar/"& MD5(BlogUser.Email) &"?s=40&d="& Server.urlEncode(GetCurrentHost & "ZB_SYSTEM/image/admin/avatar.png")%>");

if(!(($.browser.msie)&&($.browser.version)=='6.0')){
	$('input.checkbox').css("display","none");
	$('input.checkbox[value="True"]').after('<span onclick="changeCheckValue(this)" class="imgcheck imgcheck-on"></span>');
	$('input.checkbox[value="False"]').after('<span onclick="changeCheckValue(this)" class="imgcheck"></span>');
}else{
	$('input.checkbox').attr('readonly','readonly');
	$('input.checkbox').css('cursor','pointer');
	$('input.checkbox').click(function(){  if($(this).val()=='True'){$(this).val('False')}else{$(this).val('True')} })
}

});

// ]]>
</script>
<%=Response_Plugin_Admin_Footer%>
</body>
</html>