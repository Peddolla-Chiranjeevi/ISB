USE [master]
GO
/****** Object:  Database [ISB]    Script Date: 3/16/2017 4:47:39 PM ******/
CREATE DATABASE [ISB]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'ISB', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\ISB.mdf' , SIZE = 3072KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'ISB_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\ISB_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [ISB] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [ISB].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [ISB] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [ISB] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [ISB] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [ISB] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [ISB] SET ARITHABORT OFF 
GO
ALTER DATABASE [ISB] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [ISB] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [ISB] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [ISB] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [ISB] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [ISB] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [ISB] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [ISB] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [ISB] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [ISB] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [ISB] SET  DISABLE_BROKER 
GO
ALTER DATABASE [ISB] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [ISB] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [ISB] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [ISB] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [ISB] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [ISB] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [ISB] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [ISB] SET RECOVERY FULL 
GO
ALTER DATABASE [ISB] SET  MULTI_USER 
GO
ALTER DATABASE [ISB] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [ISB] SET DB_CHAINING OFF 
GO
ALTER DATABASE [ISB] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [ISB] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
EXEC sys.sp_db_vardecimal_storage_format N'ISB', N'ON'
GO
USE [ISB]
GO
/****** Object:  StoredProcedure [dbo].[add_employee_type]    Script Date: 3/16/2017 4:47:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[add_employee_type](@employee_type nvarchar(50)
									,@empTypeflag int
									,@Ret_Flag nvarchar(1)
									,@Ret_Msg nvarchar(50)
									)
AS
declare @chk int;
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	begin try
	select @chk=0 from employee_type_master where description=@employee_type
	if (@chk<>0)
	begin
		insert into employee_type_master values(@employee_type,@empTypeflag)
		select @Ret_Flag='0',@Ret_Msg='Employee type added successfully'
	end
	else
	begin
		select @Ret_Flag='1',@Ret_Msg='Employee type already exist in the list'
	end
	end try
	begin catch
		select @Ret_Flag='-1',@Ret_Msg=ERROR_MESSAGE()
	end catch
END

GO
/****** Object:  StoredProcedure [dbo].[add_product]    Script Date: 3/16/2017 4:47:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[add_product]  (@category_id int
							  ,@product_name nvarchar(50)
							  ,@product_description nvarchar(200)
							  ,@product_price money
							  ,@pieces_per_unit int
							  ,@price_per_unit money
							  ,@manufactured_by nvarchar(50)
							  ,@manufactured_date date
							  ,@expiry_date date
							  ,@quantities_in_store int
							  ,@emp_id int
							  ,@Prodid int output
							  ,@Ret_Flag nvarchar(1) output
							  ,@Ret_Msg nvarchar(max) output
							  )
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	begin try
			insert into product_master(category_id,product_name,product_description,product_price,pieces_per_unit,price_per_unit,manufactured_by,manufactured_date,expiry_date,quantities_in_store,emp_id,added_date)
								values(ISNULL(@category_id,0),ISNULL(@product_name,'NA'),isnull(@product_description,'NA'),ISNULL(@product_price,0),ISNULL(@pieces_per_unit,0),ISNULL(@price_per_unit,0),ISNULL(@manufactured_by,'NA'),ISNULL(@manufactured_date,DATEADD(DAY,-1,GETDATE())),ISNULL(@expiry_date,DATEADD(DAY,2,GETDATE())),ISNULL(@quantities_in_store,0),ISNULL(@emp_id,0),getdate())
			select @Ret_Flag='0',@Ret_Msg='Product added into the list'
			select @Prodid=productid from product_master where category_id=@category_id and product_name=@product_name
			 and product_price=@product_price
			 and manufactured_by=@manufactured_by and emp_id=@emp_id
		
	end try
	begin catch
		select @Ret_Flag='-1',@Ret_Msg=error_message()
	end catch
END

GO
/****** Object:  StoredProcedure [dbo].[add_product_category]    Script Date: 3/16/2017 4:47:40 PM ******/
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
/****** Object:  StoredProcedure [dbo].[addemployee]    Script Date: 3/16/2017 4:47:40 PM ******/
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
							,@empid int output
							)
AS
declare @ph numeric(10,0),@mail nvarchar(50);
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	begin try
	    -- Insert statements for procedure here
		if not exists(select * from employees where mobile_no=@mobile_no or email=@email)
		begin
			if @hiredate is null
			begin
				--set @hiredate=convert(nvarchar,@hiredate,103)
				insert into employees(emp_type_id,emp_name,gender,educationlevel,job,dateofbirth,mobile_no,telephone,email,address,city,pincode,salary,bonus,commission) values(@emp_type_id,@emp_name,@gender,@educationlevel,@job,@dateofbirth,@mobile_no,@telephone,@email,@address,@city,@pincode,@salary,@bonus,@commission)
				select @Ret_Flag='0',@Ret_Msg='Employee Added Successfully'
			end
			else
			begin
				set @hiredate=convert(nvarchar,@hiredate,103)
				insert into employees(emp_type_id,emp_name,gender,educationlevel,job,hiredate,dateofbirth,mobile_no,telephone,email,address,city,pincode,salary,bonus,commission) values(@emp_type_id,@emp_name,@gender,@educationlevel,@job,@hiredate,@dateofbirth,@mobile_no,@telephone,@email,@address,@city,@pincode,@salary,@bonus,@commission)
				select @Ret_Flag='0',@Ret_Msg='Employee Added Successfully'
			end
			select top 1 @empid=emp_id from employees where  mobile_no=@mobile_no or email=@email--"Returning Employee id for future refferences"
		end
		else
		begin
			select @Ret_Flag='1',@Ret_Msg='Employee Already exist with these details'
		end
	
	end try
	begin catch
		select @Ret_Flag='-1',@Ret_Msg=error_message()
	end catch
END



GO
/****** Object:  StoredProcedure [dbo].[bill_details]    Script Date: 3/16/2017 4:47:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[bill_details]	(@order_id int
								,@Ret_Flag nvarchar(1)
								,@Ret_Msg nvarchar(max)
								)
as
begin
	begin try
	if exists (select order_id from order_master where order_id=@order_id) 
		begin
		insert into bill_customer values(@order_id,(select customer_id from order_master where order_id=@order_id),(select sum(price) from cart_master where order_id=@order_id),getdate())
		select @Ret_Flag='0',@Ret_Msg='process success'
		end
	else
		select @Ret_Flag='1',@Ret_Msg='Order_id Is invalid...Please try again'
	end try
	begin catch
		select @Ret_Flag='-1',@Ret_Msg=error_message()
	end catch
end
GO
/****** Object:  StoredProcedure [dbo].[customer_cart_orders]    Script Date: 3/16/2017 4:47:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[customer_cart_orders](@order_id int
									,@Ret_Flag nvarchar(2) output
									,@Ret_Msg nvarchar(200) output
									)
AS
declare @cnt int;
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	begin try
		select @cnt=count(*) from order_master where order_id=@order_id
		if(@cnt<>0)
		begin
			if exists (select  order_id from bill_customer where order_id=@order_id)
				begin
					update bill_customer set bill_amount=(select sum(price) as 'Bill amount' from cart_master where order_id=@order_id group by order_id),bill_date=getdate()
					select @Ret_Flag='2',@Ret_Msg='Bill Updated'
				end
			else
			begin
				insert into bill_customer values(@order_id,(select customer_id from order_master where order_id=@order_id),
				(select sum(price) as 'Bill amount' from cart_master where order_id=@order_id group by order_id),getdate())
				select @Ret_Flag='0',@Ret_Msg='process successfull'
			end
		end
		else
			begin
				select @Ret_Flag='1',@Ret_Msg='invalid order_id please try again'
			end
		
	end try
	begin catch
		select @Ret_Flag='-1',@Ret_Msg=error_message()
	end catch

END


GO
/****** Object:  StoredProcedure [dbo].[customer_registration]    Script Date: 3/16/2017 4:47:40 PM ******/
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
		--print 'Registration Completed 
		--WELLCOME to "xyz Shopping"
	end
END



GO
/****** Object:  StoredProcedure [dbo].[order_customer]    Script Date: 3/16/2017 4:47:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[order_customer] (@customer_id int,@order_id int output)
as
begin
insert into order_master(customer_id) values (@customer_id)
commit transaction;
select @order_id=order_id from order_master
where customer_id=(select top 1 customer_id from order_master where customer_id=@customer_id)
end
GO
/****** Object:  StoredProcedure [dbo].[shop_cart]    Script Date: 3/16/2017 4:47:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE PROCEDURE [dbo].[shop_cart](@order_id int
							,@Product_id int
							,@product_qty int
							,@product_colour nvarchar(50)
							,@product_size nvarchar(50)
							,@Product_weight numeric(18,3)
							,@availability nvarchar(50)
							,@Ret_Flag nvarchar(2) output
							,@Ret_Msg nvarchar(200) output
							)
AS
declare @product_cost money;
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;
	begin try
		if exists(select productid from product_master where productid=@Product_id)
		begin
				select @availability=[quantities_in_store] from [dbo].[product_master] where [category_id]=@Product_id
				if(@availability=0)
				begin
					select @Ret_Flag='1',@Ret_Msg='Sorry Stock limit is over'
				end
				else
				begin
					select @product_cost=(product_price*@product_qty) from product_master where productid=@Product_id
					insert into cart_master(order_id,product_id,product_qty,product_color,product_size,product_weight,price,availability_of_product)
					values(@order_id,@Product_id,@product_qty,@product_colour,@product_size,@Product_weight,@product_cost,'stock available')
				end
			select @Ret_Flag='0',@Ret_Msg='Order Placed Successfully'
		end
		else
		select @Ret_Flag='2',@Ret_Msg='Sorry invalid entry/ Item is not exist'
	end try
	begin catch
		select @Ret_Flag='-1',@Ret_Msg=error_message()
	end catch
   END





GO
/****** Object:  StoredProcedure [dbo].[user_login_check]    Script Date: 3/16/2017 4:47:40 PM ******/
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
/****** Object:  StoredProcedure [dbo].[user_logout]    Script Date: 3/16/2017 4:47:40 PM ******/
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
/****** Object:  Table [dbo].[bill_customer]    Script Date: 3/16/2017 4:47:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[bill_customer](
	[bill_id] [int] IDENTITY(1000,1) NOT NULL,
	[order_id] [int] NULL,
	[customer_id] [int] NULL,
	[bill_amount] [money] NULL,
	[bill_date] [datetime] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[bill_payment_method]    Script Date: 3/16/2017 4:47:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[bill_payment_method](
	[bill_payment_id] [int] IDENTITY(1,1) NOT NULL,
	[order_id] [int] NULL,
	[bill_amount] [money] NULL,
	[Payment_method_type] [int] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[cart_master]    Script Date: 3/16/2017 4:47:40 PM ******/
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
/****** Object:  Table [dbo].[confirmed_payment]    Script Date: 3/16/2017 4:47:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[confirmed_payment](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[payment_mode_id] [int] NULL,
	[order_id] [int] NULL,
	[paid_amount] [money] NULL,
	[payment_refference_number] [nvarchar](50) NULL,
	[date_of_payment] [datetime] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[customers]    Script Date: 3/16/2017 4:47:40 PM ******/
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
/****** Object:  Table [dbo].[employee_type_master]    Script Date: 3/16/2017 4:47:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[employee_type_master](
	[emp_type_id] [int] IDENTITY(10,1) NOT NULL,
	[description] [nvarchar](50) NULL,
	[emptypeflag] [nvarchar](50) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[employees]    Script Date: 3/16/2017 4:47:40 PM ******/
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
/****** Object:  Table [dbo].[order_master]    Script Date: 3/16/2017 4:47:40 PM ******/
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
/****** Object:  Table [dbo].[payment_by_card]    Script Date: 3/16/2017 4:47:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[payment_by_card](
	[id] [int] IDENTITY(1000,1) NOT NULL,
	[card_no] [numeric](16, 0) NULL,
	[name_on_card] [nvarchar](100) NULL,
	[month_valid] [int] NULL,
	[year_valid] [int] NULL,
	[cvv] [int] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[payment_by_internet_banking]    Script Date: 3/16/2017 4:47:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[payment_by_internet_banking](
	[id] [int] IDENTITY(1000,1) NOT NULL,
	[bank_name] [nvarchar](50) NULL,
	[url] [nvarchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[payment_type_master]    Script Date: 3/16/2017 4:47:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[payment_type_master](
	[payment_method_type_id] [int] IDENTITY(1,1) NOT NULL,
	[payment_type] [nvarchar](50) NULL,
	[createdby] [nvarchar](50) NULL,
	[createddate] [datetime] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[product_categories]    Script Date: 3/16/2017 4:47:40 PM ******/
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
/****** Object:  Table [dbo].[product_master]    Script Date: 3/16/2017 4:47:40 PM ******/
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
/****** Object:  Table [dbo].[stock_in_store]    Script Date: 3/16/2017 4:47:40 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[stock_in_store](
	[stock_id] [int] IDENTITY(1000,1) NOT NULL,
	[product_id] [int] NULL,
	[category_id] [int] NULL,
	[product_name] [nvarchar](50) NULL,
	[inward_id] [nvarchar](50) NULL,
	[stock_in_store] [nvarchar](50) NULL,
	[stored_block] [nvarchar](50) NULL,
	[superwiser_id] [int] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[user_master]    Script Date: 3/16/2017 4:47:40 PM ******/
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

INSERT [dbo].[customers] ([customer_id], [customer_fname], [customer_mname], [customer_lname], [u_name], [password], [mobile], [phone], [mail], [address], [city], [state_name], [country], [zipcode], [created_by], [created_date], [last_updated_by], [last_updated_date]) VALUES (1, N'Raju', N'Goud', N'Bandaram', N'Raju_B', N'Raju@123', CAST(9874563210 AS Numeric(18, 0)), NULL, N'raju@gmail.com', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL)
SET IDENTITY_INSERT [dbo].[customers] OFF
SET IDENTITY_INSERT [dbo].[employee_type_master] ON 

INSERT [dbo].[employee_type_master] ([emp_type_id], [description], [emptypeflag]) VALUES (10, N'chairman', N'0')
INSERT [dbo].[employee_type_master] ([emp_type_id], [description], [emptypeflag]) VALUES (11, N'manager', N'1')
INSERT [dbo].[employee_type_master] ([emp_type_id], [description], [emptypeflag]) VALUES (12, N'supervisers', N'2')
INSERT [dbo].[employee_type_master] ([emp_type_id], [description], [emptypeflag]) VALUES (13, N'salespersons', N'3')
INSERT [dbo].[employee_type_master] ([emp_type_id], [description], [emptypeflag]) VALUES (14, N'transporter', N'4')
SET IDENTITY_INSERT [dbo].[employee_type_master] OFF
SET IDENTITY_INSERT [dbo].[order_master] ON 

INSERT [dbo].[order_master] ([order_id], [customer_id], [total_items_qty], [total_price], [emp_id], [order_date]) VALUES (1000, 1, NULL, NULL, NULL, NULL)
SET IDENTITY_INSERT [dbo].[order_master] OFF
SET IDENTITY_INSERT [dbo].[payment_by_internet_banking] ON 

INSERT [dbo].[payment_by_internet_banking] ([id], [bank_name], [url]) VALUES (1000, N'State Bank of India', N'https://retail.onlinesbi.com/retail/login.htm')
INSERT [dbo].[payment_by_internet_banking] ([id], [bank_name], [url]) VALUES (1001, N'State Bank of Hyderabad', N'https://retail.onlinesbh.com/retail/sbhlogin.htm')
INSERT [dbo].[payment_by_internet_banking] ([id], [bank_name], [url]) VALUES (1002, N'Andhra Bank', N'')
INSERT [dbo].[payment_by_internet_banking] ([id], [bank_name], [url]) VALUES (1003, N'ICICI Bank', NULL)
INSERT [dbo].[payment_by_internet_banking] ([id], [bank_name], [url]) VALUES (1004, N'HDFC Bank', NULL)
INSERT [dbo].[payment_by_internet_banking] ([id], [bank_name], [url]) VALUES (1005, N'Axis Bank', NULL)
INSERT [dbo].[payment_by_internet_banking] ([id], [bank_name], [url]) VALUES (1006, N'IndusInd Bank', NULL)
INSERT [dbo].[payment_by_internet_banking] ([id], [bank_name], [url]) VALUES (1007, N'Central Bank of India', NULL)
INSERT [dbo].[payment_by_internet_banking] ([id], [bank_name], [url]) VALUES (1008, N'IDBI Bank', NULL)
SET IDENTITY_INSERT [dbo].[payment_by_internet_banking] OFF
SET IDENTITY_INSERT [dbo].[payment_type_master] ON 

INSERT [dbo].[payment_type_master] ([payment_method_type_id], [payment_type], [createdby], [createddate]) VALUES (1, N'cash on delivery', NULL, NULL)
INSERT [dbo].[payment_type_master] ([payment_method_type_id], [payment_type], [createdby], [createddate]) VALUES (2, N'credit/debit cards', NULL, NULL)
INSERT [dbo].[payment_type_master] ([payment_method_type_id], [payment_type], [createdby], [createddate]) VALUES (3, N'internet banking', NULL, NULL)
INSERT [dbo].[payment_type_master] ([payment_method_type_id], [payment_type], [createdby], [createddate]) VALUES (4, N'Electronic payment', NULL, NULL)
SET IDENTITY_INSERT [dbo].[payment_type_master] OFF
SET IDENTITY_INSERT [dbo].[user_master] ON 

INSERT [dbo].[user_master] ([login_id], [u_name], [password], [login_flag], [login_time], [logout_time]) VALUES (1, N'Raju_B', N'Raju@123', N'Y', CAST(0x0000A73600E98E69 AS DateTime), NULL)
SET IDENTITY_INSERT [dbo].[user_master] OFF
ALTER TABLE [dbo].[employees] ADD  DEFAULT (getdate()) FOR [hiredate]
GO
ALTER TABLE [dbo].[user_master] ADD  DEFAULT ('Y') FOR [login_flag]
GO
ALTER TABLE [dbo].[user_master] ADD  DEFAULT (getdate()) FOR [login_time]
GO
USE [master]
GO
ALTER DATABASE [ISB] SET  READ_WRITE 
GO
