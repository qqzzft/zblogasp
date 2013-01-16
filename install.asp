<%@ CODEPAGE=65001 %>
<%
'///////////////////////////////////////////////////////////////////////////////
'//              Z-Blog 在线安装程序
'///////////////////////////////////////////////////////////////////////////////
%>
<% Option Explicit %>
<% 'On Error Resume Next %>
<% Response.Charset="UTF-8" %>
<%Response.Buffer=True %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="zh-cn" lang="zh-cn">
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta http-equiv="Content-Language" content="zh-cn" />
	<title>Z-Blog2在线安装程序</title>
<style type="text/css">
<!--
*{
	font-size:14px;
	border:none;
}
body{
	margin:0;
	padding:0;
	color: #000000;
	background:#fff;
	font-family:"宋体","黑体";
}
h1,h2,h3,h4,h5,h6{
	font-size:18px;
	padding:0;
	margin:0;
}
div{
	position:absolute;
	left: 50%;
	top: 50%;
	margin: -120px 0px 0px -100px;
	padding:0;
	overflow:hidden;
	width:200px;
	height:240px;
	background-color:white;
	text-align:center;
}
-->
</style>
</head>
<body>
<div>
<h3>Z-Blog2在线安装程序</h3>
<p><img src="http://update.rainbowsoft.org/zblog2/loading.gif" alt=""></p>

<%
Dim fso
Set fso = CreateObject("Scripting.FileSystemObject")
If fso.FileExists(Server.MapPath(".") & "\" & "Release.log")=True Then
	Response.Write "<p>已运行过安装程序...</p>"
Else

	If fso.FileExists(Server.MapPath(".") & "\" & "Release.xml")=True Then
		Install2
	Else
		Install1
		Install2
	End If

End If





Function Install1

	Response.Write "<p>正在努力的下载数据包...</p>"
	Response.Flush

	Dim objPing
	Set objPing = Server.CreateObject("Microsoft.XMLHTTP")

	objPing.open "GET", "http://update.rainbowsoft.org/zblog2?install",False
	objPing.setRequestHeader "accept-encoding", "gzip, deflate"  
	objPing.send ""

	Dim MyStream
    Set MyStream=Server.CreateObject("Adodb.Stream") 
	MyStream.Type = 1
	MyStream.Mode = 3
    MyStream.Open 
    MyStream.Write objPing.responsebody
    MyStream.SaveToFile Server.MapPath(".") & "\" & "Release.xml" ,2
End Function

Function Install2

	Response.Write "<p>正在解压和安装文件...</p>"
	Response.Flush

	Dim objXmlFile,strXmlFile
	Dim fso, f, f1, fc, s
	Set fso = CreateObject("Scripting.FileSystemObject")

	strXmlFile =Server.MapPath(".") & "\" & "Release.xml"
	
	If fso.FileExists(strXmlFile) Then

		Set objXmlFile=Server.CreateObject("Microsoft.XMLDOM")
		objXmlFile.async = False
		objXmlFile.ValidateOnParse=False
		objXmlFile.load(strXmlFile)
		If objXmlFile.readyState=4 Then
			If objXmlFile.parseError.errorCode <> 0 Then
			Else



				Dim objXmlFiles,item,objStream
				Set objXmlFiles=objXmlFile.documentElement.SelectNodes("file")
				for each item in objXmlFiles
				Set objStream = CreateObject("ADODB.Stream")
					With objStream
					.Type = 1
					.Mode = 3
					.Open
					.Write item.nodeTypedvalue
					
					Dim i,j,k,l
					i=item.getAttributeNode("name").Value

					j=Left(i,InstrRev(i,"\"))
					k=Replace(i,j,"")
					Call CreatDirectoryByCustomDirectory("" & j)

					.SaveToFile Server.MapPath(".") & "\" & item.getAttributeNode("name").Value,2

					's=s& "释放 " & k & ";"
					.Close
					End With
					Set objStream = Nothing
					l=l+1
				next


			End If
		End If
	End If


	Call fso.CreateTextFile(Server.MapPath(".") & "\" & "Release.log", True)

	Response.Write "<script>location=""zb_install/default.asp""</script>"

End Function


'*********************************************************
' 目的：    按照CustomDirectory指示创建相应的目录
'*********************************************************
Sub CreatDirectoryByCustomDirectory(ByVal strCustomDirectory)

	On Error Resume Next

	Dim s
	Dim t
	Dim i
	Dim j

	Dim fso
	Set fso = CreateObject("Scripting.FileSystemObject")

	s=Server.MapPath(".") & "\"

	strCustomDirectory=Replace(strCustomDirectory,"/","\")

	t=Split(strCustomDirectory,"\")

	j=0
	For i=LBound(t) To UBound(t)
		If (IsEmpty(t(i))=False) And (t(i)<>"") Then
			s=s & t(i) & "\"
			If (fso.FolderExists(s)=False) Then
				Call fso.CreateFolder(s)
			End If
			j=j+1
		End If
	Next

	Set fso = Nothing

	Err.Clear

End Sub
'*********************************************************


%>
</div>
</body>
</html>