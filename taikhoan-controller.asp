
<!--#include file="./models/taiKhoan.asp" -->
<%  
    'status code 1: dang nhap thanh cong
    'status code 2: sai mat khau
    'status code 3: sai loai tai khoan
    'status code 4: tai khoan khong ton tai
    'status code 5: tai khoan dang bi khoa
    'status code 6: lay danh sach tai khoan phan trang
    loai = request.Form("loai")
    dim page 
    Set danhsachtaikhoan = Server.CreateObject("Scripting.Dictionary")
    limit = 10
    
    if(true) then
        set tk = new TaiKhoan
        page = request.form("page")
        taikhoansearch = request.form("taikhoan")
        tennguoidung = request.form("tennguoidung")
        diachi = request.form("diachi")
        sodienthoai = request.form("sodienthoai")
        tichdiem = request.form("tichdiem")
        trangthai = request.form("trangthai")
        sapxepten = request.form("sapxepten")
        sapxeptichdiem = request.form("sapxeptichdiem")
        sapxepdiachi = request.form("sapxepdiachi")
        set danhsachtaikhoan = tk.phanTrangTaiKhoan(limit,page,taikhoansearch,tennguoidung,diachi,sodienthoai,tichdiem,trangthai,sapxepten,sapxepdiachi,sapxeptichdiem)
        Response.Write("{")
        Response.Write("""status code"": ""6"",")
        Response.Write("""message"": """",")
        Response.Write("""data"":{ ""danhsachtaikhoan"": [")
        dim count 
        count = 0
        for each z in danhsachtaikhoan
            count = count + 1
            Response.Write("{")
            Response.Write("")
            response.write("""taikhoan"": """)
            response.write(danhsachtaikhoan(z).Tk)
            response.write(""",")
            response.write("""ten"": """)
            response.write(danhsachtaikhoan(z).Ten)
            response.write("""")
            response.write(",")
            response.write("""sdt"": """)
            response.write(danhsachtaikhoan(z).Sdt)
            response.write("""")
            response.write(",")
            response.write("""tinhtrang"": """)
            response.write(danhsachtaikhoan(z).Tinhtrang)
            response.write("""")
            response.write(",")
            response.write("""tichdiem"": """)
            response.write(danhsachtaikhoan(z).Tichdiem)
            response.write("""")
            response.write(",")
            response.write("""diachi"": """)
            response.write(danhsachtaikhoan(z).Diachi)
            response.write("""")
            Response.Write("}")
            if(count < danhsachtaikhoan.count) then
                response.write(",")
            end if

        next
        Response.Write("]")
        Response.Write(",""totalPages"":")
        Response.Write(tk.Ceil(tk.count(taikhoansearch,tennguoidung,diachi,sodienthoai,tichdiem,trangthai)/limit))
        Response.Write("")
        Response.Write("}")
        Response.Write("}")
    end if

    if(loai = "phantrangtaikhoanquanly") then
        set tk = new TaiKhoan
        Set danhsachtaikhoan = Server.CreateObject("Scripting.Dictionary")
        page = request.form("page")
        set danhsachtaikhoan = tk.phanTrangTaiKhoanQuanLy(offset,limit,page)
    end if

    if(loai = "unban") then
        set tk = new TaiKhoan
        set tentk= Request.Form("tk")
        tk.moKhoaTaiKhoan(tentk)       
    end if

    if(loai = "ban") then
        set tk = new TaiKhoan
        set tentk= Request.Form("tk")
        tk.khoaTaiKhoan(tentk)       
    end if

    If (loai="admindangnhap") Then
    Set classtk = New TaiKhoan
    dim tk
    tk = Request.Form("tk")
    dim mk
    mk = Request.Form("mk")
    Response.Write("{")
    If (classtk.checkTonTai(tk)) Then
        If (classtk.getLoaiTK(tk) <> "0") Then
            If(classtk.getTinhTrang(tk) = True) Then
                If(classtk.checkMK(tk,mk)) Then
                    Session("uid") = classtk.getUID(tk)
                    Response.Write("""status code"": ""1"",")
                    Response.Write("""message"": """",")
                    Response.Write("""data"":{ ""checkLogin"": true}")
                Else
                    Response.Write("""status code"": ""2"",")
                    Response.Write("""message"": ""Sai mật khẩu!"",")
                    Response.Write("""data"":{ ""checkLogin"": false}")
                End If
            Else
                Response.Write("""status code"": ""3"",")
                Response.Write("""message"": ""Tài khoản của bạn đang bị khóa!"",")
                Response.Write("""data"":{ ""checkLogin"": false}")
            End if
        Else
            Response.Write("""status code"": ""4"",")
            Response.Write("""message"": ""Sai loại tài khoản!"",")
            Response.Write("""data"":{ ""checkLogin"": false}")
        End If
    Else
        Response.Write("""status code"": ""5"",")
        Response.Write("""message"": ""Tài khoản không tồn tại!"",")
        Response.Write("""data"":{ ""checkLogin"": false}")
    End If
    Response.Write("}")
    End If

%>  