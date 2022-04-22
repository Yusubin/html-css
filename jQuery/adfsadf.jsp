<style>
    table {
        width: 100%;
        border-top: 1px solid #444444;
        border-collapse: collapse;
    }
    th, td {
        border-bottom: 1px solid #444444;
        padding: 10px;
    }
</style>
<script>
function search(){
    var frm = document.form;
    
    //if(frm.searchValue.value == ''){
        //alert('검색어를 입력해주세요.');
        //return;
    //}
    
    frm.submit();
}

function insert(){
    location = "member.html";
}
</script>
<body>
<h2>회원목록</h2>
<%
Connection con = null;           // database 연결을 위한 객체
PreparedStatement pstmt  = null; // SQL 문을 서버로 보내기 위한 객체
ResultSet rs   = null;           // SQL을 실행하고 결과를 받기 위한 객체

Class.forName("com.mysql.jdbc.Driver");
System.out.println("1. Connector 라이브러리 설정 성공 @@");
//2. db 연결 승인된 사용자 (ip+port, user(root), pw db명(big)) 
String url = "jdbc:mysql://localhost:3366/board";
String user ="root";
String pass = "1234";

String query = "SELECT * FROM board ORDER BY m_idx DESC";
String searchValue = "";
if(request.getParameter("searchValue") != null){
    searchValue = request.getParameter("searchValue");
}
try {
  
    Connection con=DriverManager.getConnection(url, user, pass);

    //3. PreparedStatement 객체 생성
    if(request.getParameter("searchValue") != null){
        sql = "SELECT * FROM border WHERE name LIKE ? ORDER BY idx DESC";
    }
    PreparedStatement ps = con.prepareStatement(sql);
    if(request.getParameter("searchValue") != null){
        ps.setString(1, "%"+request.getParameter("searchValue")+"%");
    }
    rs = pstmt.executeQuery();
    
    SimpleDateFormat format1 = new SimpleDateFormat("yyyy.MM.dd");
%>
<form action="boardList.jsp" name="form">
    <input type="text" name="searchValue" value="<%=searchValue%>">
    <input type="button" onclick="search()" value="검색">
    <input type="button" onclick="insert()" value="회원가입">
</form>
<table>
    <tr>
        <td>시퀀스</td>
        <td>제목</td>
        <td>내용</td>
        <td>작성자</td>
        <td>등록일</td>
    <tr>
    <%
        while(rs.next()){
    %>
    <tr>
        <td><%=rs.getString("idx")%></td>
        <td><%=rs.getString("title")%></td>
        <td><%=rs.getString("content")%></td>
        <td><%=rs.getString("name")%></td>
        <td><%=format1.format(rs.getTimestamp("m_rgstdate"))%></td>
    <tr>
    <%
        }
    %>
</table>
<%
//} catch (ClassNotFoundException e) {
    // TODO Auto-generated catch block
    //e.printStackTrace();
} catch (SQLException e) {
    // TODO Auto-generated catch block
    e.printStackTrace();
} finally {
    if(pstmt != null){
        try {
            pstmt.close();
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
    }
    if(rs != null) {
        try {
            rs.close();
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }	
    }
    
    if(con != null) {
        try {
            con.close();
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }	
    }
}
%>