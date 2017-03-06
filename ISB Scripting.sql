USE [master]
GO
/****** Object:  Database [Ecommerce2]    Script Date: 3/6/2017 7:42:12 PM ******/
CREATE DATABASE [Ecommerce2]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Ecommerce2', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\Ecommerce2.mdf' , SIZE = 3072KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'Ecommerce2_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\Ecommerce2_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [Ecommerce2] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Ecommerce2].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Ecommerce2] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Ecommerce2] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Ecommerce2] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Ecommerce2] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Ecommerce2] SET ARITHABORT OFF 
GO
ALTER DATABASE [Ecommerce2] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Ecommerce2] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [Ecommerce2] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Ecommerce2] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Ecommerce2] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Ecommerce2] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Ecommerce2] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Ecommerce2] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Ecommerce2] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Ecommerce2] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Ecommerce2] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Ecommerce2] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Ecommerce2] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Ecommerce2] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Ecommerce2] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Ecommerce2] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Ecommerce2] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Ecommerce2] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Ecommerce2] SET RECOVERY FULL 
GO
ALTER DATABASE [Ecommerce2] SET  MULTI_USER 
GO
ALTER DATABASE [Ecommerce2] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Ecommerce2] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Ecommerce2] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Ecommerce2] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
EXEC sys.sp_db_vardecimal_storage_format N'Ecommerce2', N'ON'
GO
USE [Ecommerce2]
GO
/****** Object:  StoredProcedure [dbo].[add_product_category]    Script Date: 3/6/2017 7:42:12 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[add_product_category](	@category_name nvarchar(50)
										,@description nvarchar(200)
										,@emp_id nvarchar(50)
										,@added_date datetime
										,@Ret_Flag nvarchar(1) output
										,@Ret_Msg nvarchar(200) output
										)
AS
declare @add_date datetime;
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	begin try
	if (@emp_id is NOT NULL)
	begin
			-- Insert statements for procedure here
		set @add_date=ISNULL(@added_date,getdate())
		insert into product_categories(category_Name,description,emp_id,added_date)values(@category_name,@description,@emp_id,@add_date)
		select @Ret_Flag='0',@Ret_Msg='New Category Added Successfully'
	end
	else
		select @Ret_Flag='1',@Ret_Msg='Please Give Employee Id'
	end try
	begin catch
		select @Ret_Flag='-1',@Ret_Msg=ERROR_MESSAGE()
	end catch
END

GO
/****** Object:  StoredProcedure [dbo].[addemployee]    Script Date: 3/6/2017 7:42:12 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[addemployee](@emp_type_id int
							,@emp_name nvarchar(50)
							,@gender nvarchar(50)
							,@educationlevel nvarchar(100)
							,@job nvarchar(50)
							,@hiredate date
							,@dateofbirth date
							,@mobile_no numeric(10,0)
							,@telephone nvarchar(20)
							,@email nvarchar(50)
							,@address nvarchar(100)
							,@city nvarchar(50)
							,@pincode numeric(10)
							,@salary money
							,@bonus money
							,@commission money
							,@Ret_Flag nvarchar(1) output
							,@Ret_Msg nvarchar(200) output
							)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	begin try
	    -- Insert statements for procedure here
		set @hiredate=convert(nvarchar,@hiredate,103)
	insert into employees(emp_type_id,emp_name,gender,educationlevel,job,hiredate,dateofbirth,mobile_no,telephone,email,address,city,pincode,salary,bonus,commission) values(@emp_type_id,@emp_name,@gender,@educationlevel,@job,@hiredate,@dateofbirth,@mobile_no,@telephone,@email,@address,@city,@pincode,@salary,@bonus,@commission)
	select @Ret_Flag='0',@Ret_Msg='Employee Added Successfully'
	end try
	begin catch
		select @Ret_Flag='-1',@Ret_Msg=error_message()
	end catch
END

GO
/****** Object:  StoredProcedure [dbo].[customer_registration]    Script Date: 3/6/2017 7:42:12 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[customer_registration](@customer_fname nvarchar(50)
										,@customer_mname nvarchar(50)
										,@customer_lname nvarchar(50)
										,@user_name nvarchar(50)
										,@password nvarchar(50)
										,@mobile numeric(18,0)
										,@phone nvarchar(50)
										,@mail nvarchar(50)
										,@address nvarchar(50)
										,@city nvarchar(50)
										,@state_name nvarchar(50)
										,@country nvarchar(50)
										,@zipcode numeric(18,0)	
										,@created_by nvarchar(50)
										,@created_date datetime
										,@last_updated_by nvarchar(50)
										,@last_updated_date datetime	
										,@Ret_Flag nvarchar(2) output
										,@Ret_Msg nvarchar(200) output								
										)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	begin try
		if not exists(select * from customers where u_name=@user_name)
		begin
			if not exists(select * from customers where  mail=@mail)
			begin
				if not exists(select * from customers where mobile=@mobile)
				begin
					insert into customers values(@customer_fname,@customer_mname,@customer_lname,@user_name,@password,@mobile,@phone,@mail,@address,@city,@state_name,@country,@zipcode,@created_by,@created_date,@last_updated_by,@last_updated_date);
					select @Ret_Flag='0',@Ret_Msg='Regitration Successfully Completed'
				end
				else
				begin
					select @Ret_Flag='1',@Ret_Msg='Mobile Number Already Registered' --if moble number already registered
				end
			end
			else
			begin
				select @Ret_Flag='2',@Ret_Msg='Mail Already Registered' --if Customer Mail Id already registered
			end
		end
		else
			begin
				select @Ret_Flag='3',@Ret_Msg='User Name Already Exist' --if Username Exist
			end
	end try
	begin catch
		select @Ret_Flag='-1',@Ret_Msg=ERROR_MESSAGE();
	end catch
	if(@Ret_Flag='0')
	begin 
		commit transaction;
		--print 'Registration Completed enjoy your Shopping'
	end
END


GO
/****** Object:  StoredProcedure [dbo].[user_login_check]    Script Date: 3/6/2017 7:42:12 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[user_login_check]	(@u_name nvarchar(50)
									,@password nvarchar(50)
									,@Ret_Flag nvarchar(1) output
									,@Ret_Msg nvarchar(MAX) output
									)
AS
BEGIN
Declare  @cnt numeric(18,0)
		,@Login_Flag nvarchar(1)
	SET NOCOUNT ON;
	begin try
		select @cnt=count(*) from user_master where u_name=@u_name and Password=@password
		if(@cnt=1)
		begin
			select @Login_Flag=login_flag from user_master where u_name=@u_name and Password=@password
			if(@Login_Flag='Y')
			begin
				select customer_id,customer_fname,customer_mname,customer_lname,mobile,mail from customers where u_name=@u_name and password=@password
				update user_master set login_flag='N',login_time=getdate() where u_name=@u_name and Password=@password and login_flag='Y'
				select @Ret_Flag='0',@Ret_Msg='Successfully Loged In'
			end
			else
			begin
				set @ret_flag='2'
				set @ret_msg='User Already Logged In'
			end
		end
		else
		begin
			set @ret_flag='1'
			set @ret_msg='Incorrect UserName or Password'
		end
	end try
	begin catch
		set @ret_flag='-1'
		set @ret_msg=ERROR_MESSAGE()
	end catch
end


GO
/****** Object:  StoredProcedure [dbo].[user_logout]    Script Date: 3/6/2017 7:42:12 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[user_logout](--@u_name int
									--,@password nvarchar(50)	
									@login_id int
									,@Ret_Flag nvarchar(1) output
									,@Ret_Msg nvarchar(max) output
									)
AS
declare @login_flag nvarchar(1);
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	begin try
		select @login_flag=login_flag from user_master where login_id=@login_id
		if(@login_flag='N')
			begin
				update  user_master set login_flag='Y',logout_time=getdate() where login_id=@login_id
				select @Ret_Flag='0',@Ret_Msg='Logged Out Successfully'
			end
		else
			select @Ret_Flag='3',@Ret_Msg='User Not logged In'
	end try
	begin catch
	
	end catch
END


GO
/****** Object:  Table [dbo].[cart_master]    Script Date: 3/6/2017 7:42:12 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[cart_master](
	[cart_id] [int] NULL,
	[order_id] [int] NULL,
	[product_id] [int] NULL,
	[product_qty] [int] NULL,
	[product_color] [nvarchar](50) NULL,
	[product_size] [nvarchar](50) NULL,
	[product_weight] [numeric](18, 3) NULL,
	[price] [money] NULL,
	[availability_of_product] [nvarchar](3) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[customers]    Script Date: 3/6/2017 7:42:12 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[customers](
	[customer_id] [int] IDENTITY(1,1) NOT NULL,
	[customer_fname] [nvarchar](50) NULL,
	[customer_mname] [nvarchar](50) NULL,
	[customer_lname] [nvarchar](50) NULL,
	[u_name] [nvarchar](50) NULL,
	[password] [nvarchar](50) NULL,
	[mobile] [numeric](18, 0) NULL,
	[phone] [nvarchar](20) NULL,
	[mail] [nvarchar](50) NOT NULL,
	[address] [nvarchar](100) NULL,
	[city] [nvarchar](50) NULL,
	[state_name] [nvarchar](50) NULL,
	[country] [nvarchar](50) NULL,
	[zipcode] [numeric](10, 0) NULL,
	[created_by] [nvarchar](50) NULL,
	[created_date] [datetime] NULL,
	[last_updated_by] [nvarchar](50) NULL,
	[last_updated_date] [datetime] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[employees]    Script Date: 3/6/2017 7:42:12 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[employees](
	[emp_id] [int] IDENTITY(100,1) NOT NULL,
	[emp_type_id] [int] NULL,
	[emp_name] [nvarchar](50) NULL,
	[gender] [nvarchar](10) NULL,
	[educationlevel] [nvarchar](100) NULL,
	[job] [nvarchar](50) NULL,
	[hiredate] [date] NULL,
	[dateofbirth] [date] NULL,
	[mobile_no] [numeric](10, 0) NULL,
	[telephone] [nvarchar](20) NULL,
	[email] [nvarchar](50) NULL,
	[address] [nvarchar](100) NULL,
	[city] [nvarchar](50) NULL,
	[pincode] [numeric](10, 0) NULL,
	[salary] [money] NULL,
	[bonus] [money] NULL,
	[commission] [money] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[order_master]    Script Date: 3/6/2017 7:42:12 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[order_master](
	[order_id] [int] IDENTITY(1000,1) NOT NULL,
	[customer_id] [int] NULL,
	[total_items_qty] [int] NULL,
	[total_price] [money] NULL,
	[emp_id] [nvarchar](50) NULL,
	[order_date] [datetime] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[product_categories]    Script Date: 3/6/2017 7:42:12 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[product_categories](
	[category_id] [int] IDENTITY(1,1) NOT NULL,
	[category_Name] [nvarchar](50) NULL,
	[description] [nvarchar](200) NULL,
	[emp_id] [nvarchar](50) NULL,
	[added_date] [datetime] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[product_master]    Script Date: 3/6/2017 7:42:12 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[product_master](
	[productid] [int] IDENTITY(1,1) NOT NULL,
	[category_id] [int] NULL,
	[product_name] [nvarchar](100) NULL,
	[product_description] [nvarchar](200) NULL,
	[product_price] [money] NULL,
	[pieces_per_unit] [int] NULL,
	[price_per_unit] [money] NULL,
	[manufactured_by] [nvarchar](50) NULL,
	[manufactured_date] [datetime] NULL,
	[expiry_date] [datetime] NULL,
	[quantities_in_store] [int] NULL,
	[emp_id] [nvarchar](50) NULL,
	[added_date] [datetime] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[user_master]    Script Date: 3/6/2017 7:42:12 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[user_master](
	[login_id] [int] IDENTITY(1,1) NOT NULL,
	[u_name] [nvarchar](50) NULL,
	[password] [nvarchar](50) NULL,
	[login_flag] [nvarchar](1) NULL,
	[login_time] [datetime] NULL,
	[logout_time] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[login_id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET IDENTITY_INSERT [dbo].[customers] ON 

INSERT [dbo].[customers] ([customer_id], [customer_fname], [customer_mname], [customer_lname], [u_name], [password], [mobile], [phone], [mail], [address], [city], [state_name], [country], [zipcode], [created_by], [created_date], [last_updated_by], [last_updated_date]) VALUES (1, N'RAJU', N'GOUD', N'BANDARAM', N'RAJU', N'123456', CAST(9876543210 AS Numeric(18, 0)), NULL, N'RAJU@GMAIL.COM', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
SET IDENTITY_INSERT [dbo].[customers] OFF
SET IDENTITY_INSERT [dbo].[product_categories] ON 

INSERT [dbo].[product_categories] ([category_id], [category_Name], [description], [emp_id], [added_date]) VALUES (1, N'food', NULL, NULL, CAST(0x0000A72E00EA8118 AS DateTime))
INSERT [dbo].[product_categories] ([category_id], [category_Name], [description], [emp_id], [added_date]) VALUES (2, N'footware', NULL, N'1', CAST(0x0000A72E00ECF791 AS DateTime))
SET IDENTITY_INSERT [dbo].[product_categories] OFF
SET IDENTITY_INSERT [dbo].[user_master] ON 

INSERT [dbo].[user_master] ([login_id], [u_name], [password], [login_flag], [login_time], [logout_time]) VALUES (1, N'RAJU', N'123456', N'Y', CAST(0x0000A72E00BFFDC0 AS DateTime), CAST(0x0000A72E00C04252 AS DateTime))
SET IDENTITY_INSERT [dbo].[user_master] OFF
ALTER TABLE [dbo].[employees] ADD  CONSTRAINT [DF_employees_hiredate]  DEFAULT (getdate()) FOR [hiredate]
GO
ALTER TABLE [dbo].[user_master] ADD  DEFAULT ('Y') FOR [login_flag]
GO
ALTER TABLE [dbo].[user_master] ADD  DEFAULT (getdate()) FOR [login_time]
GO
USE [master]
GO
ALTER DATABASE [Ecommerce2] SET  READ_WRITE 
GO
