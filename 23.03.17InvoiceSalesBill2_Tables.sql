USE [InvoiceSalesBill]
GO
/****** Object:  Table [dbo].[Bill_Master]    Script Date: 3/23/2017 12:07:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Bill_Master](
	[Bill_Id] [int] NULL,
	[Order_Id] [int] NULL,
	[Customer_Id] [int] NULL,
	[Taxes_Amount] [money] NULL,
	[Bill_Amount] [money] NULL,
	[Bill_Date] [datetime] NULL,
	[Active_Flag] [nvarchar](1) NULL,
	[Payment_Confirmation_Flag] [nvarchar](1) NULL,
	[Added_By] [int] NULL,
	[Added_Date] [datetime] NULL,
	[Last_Updated_By] [int] NULL,
	[Last_Updated_Date] [datetime] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Cart_Master]    Script Date: 3/23/2017 12:07:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Cart_Master](
	[Cart_Id] [int] NULL,
	[Order_Id] [int] NULL,
	[Product_Id] [int] NULL,
	[Product_Qty] [int] NULL,
	[Availability_Of_Product] [nvarchar](3) NULL,
	[Active_Flag] [nvarchar](1) NULL,
	[Order_Date] [datetime] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Customer_Order]    Script Date: 3/23/2017 12:07:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Customer_Order](
	[SNo] [int] NULL,
	[Order_Id] [int] NULL,
	[Customer_Id] [int] NULL,
	[Active_Flag] [nvarchar](1) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Customers]    Script Date: 3/23/2017 12:07:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Customers](
	[Customer_Id] [int] NULL,
	[Customer_FName] [nvarchar](50) NULL,
	[Customer_MName] [nvarchar](50) NULL,
	[Customer_LName] [nvarchar](50) NULL,
	[User_Name] [nvarchar](50) NULL,
	[Password] [nvarchar](50) NULL,
	[Mobile] [numeric](18, 0) NULL,
	[Phone] [nvarchar](20) NULL,
	[Mail] [nvarchar](50) NOT NULL,
	[Address] [nvarchar](100) NULL,
	[City] [nvarchar](50) NULL,
	[State_Name] [nvarchar](50) NULL,
	[Country] [nvarchar](50) NULL,
	[Zipcode] [numeric](10, 0) NULL,
	[Created_By] [nvarchar](50) NULL,
	[Created_Date] [datetime] NULL,
	[Last_Updated_By] [nvarchar](50) NULL,
	[Last_Updated_Date] [datetime] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Delivery_Confirmation]    Script Date: 3/23/2017 12:07:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Delivery_Confirmation](
	[SNo] [int] NULL,
	[Order_To_Shipper_Id] [int] NULL,
	[Delivery_Person_Name] [nvarchar](50) NULL,
	[If_Delivery_Boy_Id] [int] NULL,
	[Received_By] [nvarchar](50) NULL,
	[Received_Date] [datetime] NULL,
	[If_Orthers_Received_Relation] [nvarchar](50) NULL,
	[Review_From_Customer] [nvarchar](100) NULL,
	[Active_Flag] [nvarchar](1) NULL,
	[Added_By] [int] NULL,
	[Added_Date] [datetime] NULL,
	[Last_Updated_By] [int] NULL,
	[Last_Updated_Date] [datetime] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Employee_Type_Master]    Script Date: 3/23/2017 12:07:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Employee_Type_Master](
	[Emp_Type_Id] [int] IDENTITY(10,1) NOT NULL,
	[Description] [nvarchar](50) NULL,
	[Active_Flag] [nvarchar](50) NULL,
	[Added_By] [int] NULL,
	[Added_Date] [datetime] NULL,
	[Last_Updated_By] [int] NULL,
	[Last_Updated_Date] [datetime] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Employees]    Script Date: 3/23/2017 12:07:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Employees](
	[Emp_Id] [int] NULL,
	[Emp_Type_Id] [int] NULL,
	[Emp_Name] [nvarchar](50) NULL,
	[Gender] [nvarchar](10) NULL,
	[Educationlevel] [nvarchar](100) NULL,
	[Job] [nvarchar](50) NULL,
	[Hiredate] [date] NULL,
	[Dateofbirth] [date] NULL,
	[Mobile_No] [numeric](10, 0) NULL,
	[Telephone] [nvarchar](20) NULL,
	[Email] [nvarchar](50) NULL,
	[Address] [nvarchar](100) NULL,
	[City] [nvarchar](50) NULL,
	[Pincode] [numeric](10, 0) NULL,
	[Salary] [money] NULL,
	[Bonus] [money] NULL,
	[Commission] [money] NULL,
	[Added_By] [int] NULL,
	[Added_Date] [datetime] NULL,
	[Last_Updated_By] [int] NULL,
	[Last_Updated_Date] [datetime] NULL,
	[Active_Flag] [nvarchar](1) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Invoice_Bill]    Script Date: 3/23/2017 12:07:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Invoice_Bill](
	[Invoice_Bill_Id] [int] NULL,
	[Invoice_Id] [int] NULL,
	[Total_Amount] [money] NULL,
	[Vat_Amount] [money] NULL,
	[Swach_Bharat_Tax] [money] NULL,
	[Other_Taxes] [money] NULL,
	[Grand_Total] [money] NULL,
	[Active_Flag] [nvarchar](1) NULL,
	[Added_By] [int] NULL,
	[Added_Date] [datetime] NULL,
	[Last_Updated_By] [int] NULL,
	[Last_Updated_Date] [datetime] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Invoice_Master]    Script Date: 3/23/2017 12:07:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Invoice_Master](
	[Invoice_Id] [int] NULL,
	[Dispatch_To] [nvarchar](50) NULL,
	[Supplier_Id] [int] NULL,
	[Total_Amount] [money] NULL,
	[Invoice_Copy_Image_Location] [nvarchar](50) NULL,
	[Active_Flag] [nvarchar](1) NULL,
	[Added_By] [int] NULL,
	[Added_Date] [datetime] NULL,
	[Last_Updated_By] [int] NULL,
	[Last_Updated_Date] [datetime] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Inward_Master]    Script Date: 3/23/2017 12:07:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Inward_Master](
	[Inward_SNo] [int] NULL,
	[Invoice_Id] [int] NULL,
	[Material_Type] [nvarchar](50) NULL,
	[Product_Id] [int] NULL,
	[Quantity] [nvarchar](50) NULL,
	[If_Weight] [numeric](18, 0) NULL,
	[If_Coloured] [nvarchar](50) NULL,
	[Unit] [nvarchar](50) NULL,
	[Rate] [money] NULL,
	[Amount] [money] NULL,
	[Transport_Ttype_Id] [int] NULL,
	[Company_Id] [int] NULL,
	[Inward_By] [int] NULL,
	[Inward_Date] [datetime] NULL,
	[Active_Flag] [nvarchar](1) NULL,
	[Added_By] [int] NULL,
	[Added_Date] [datetime] NULL,
	[Last_Updated_By] [int] NULL,
	[Last_Updated_Date] [datetime] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[MaterialSupplyCompany]    Script Date: 3/23/2017 12:07:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MaterialSupplyCompany](
	[Company_Id] [int] NULL,
	[Company_Name] [nvarchar](50) NULL,
	[Contact_Person] [nvarchar](50) NULL,
	[Mobile] [numeric](10, 0) NULL,
	[Mail] [nvarchar](50) NULL,
	[Active_Flag] [nvarchar](1) NULL,
	[Added_By] [int] NULL,
	[Added_Date] [datetime] NULL,
	[updated_By] [int] NULL,
	[updated_Date] [datetime] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Order_To_Shipper]    Script Date: 3/23/2017 12:07:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Order_To_Shipper](
	[Order_To_Shipper_Id] [int] NULL,
	[Order_Id] [int] NULL,
	[Customer_Id] [int] NULL,
	[Shipper_Id] [int] NULL,
	[Assigned_By] [int] NULL,
	[Assigned_Date] [datetime] NULL,
	[Active_Flag] [nvarchar](1) NULL,
	[Dispatched_Date] [datetime] NULL,
	[Expected_Delivery_Date] [datetime] NULL,
	[Delivery_Confirmation_Flag] [nvarchar](1) NULL,
	[Last_Updated_By] [int] NULL,
	[Last_Updated_Date] [datetime] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Payment_By_Card]    Script Date: 3/23/2017 12:07:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Payment_By_Card](
	[Id] [int] NULL,
	[Order_Id] [int] NULL,
	[Card_No] [numeric](16, 0) NULL,
	[Name_On_Card] [nvarchar](100) NULL,
	[Card_Type_Name] [nvarchar](50) NULL,
	[Month_Valid] [int] NULL,
	[Year_Valid] [int] NULL,
	[CVV] [int] NULL,
	[Pin] [numeric](18, 0) NULL,
	[OTP] [nvarchar](20) NULL,
	[Active_Flag] [nvarchar](1) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Payment_By_Internet_Banking]    Script Date: 3/23/2017 12:07:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Payment_By_Internet_Banking](
	[Id] [int] NULL,
	[Bank_Name] [nvarchar](50) NULL,
	[URL] [nvarchar](max) NULL,
	[Added_By] [int] NULL,
	[Added_Date] [datetime] NULL,
	[Last_Updated_By] [int] NULL,
	[Last_Updated_Date] [datetime] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Payment_Confirmation]    Script Date: 3/23/2017 12:07:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Payment_Confirmation](
	[Id] [int] NULL,
	[Order_Id] [int] NULL,
	[Payment_Mode_Id] [int] NULL,
	[Paid_Amount] [money] NULL,
	[Payment_Refference_Number] [nvarchar](50) NULL,
	[Date_Of_Payment] [datetime] NULL,
	[Payment_Success_Flag] [nvarchar](1) NULL,
	[Active_Flag] [nvarchar](1) NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Payment_Type_Master]    Script Date: 3/23/2017 12:07:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Payment_Type_Master](
	[Payment_Method_Type_Id] [int] NULL,
	[Payment_Type] [nvarchar](50) NULL,
	[Active_Flag] [nvarchar](1) NULL,
	[Added_By] [int] NULL,
	[Added_Date] [datetime] NULL,
	[Last_Updated_By] [int] NULL,
	[Last_Updated_Date] [datetime] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Product_Category]    Script Date: 3/23/2017 12:07:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Product_Category](
	[Category_Id] [int] IDENTITY(10,1) NOT NULL,
	[Category_Name] [nvarchar](50) NULL,
	[Description] [nvarchar](max) NULL,
	[Photo_Location] [nvarchar](max) NULL,
	[Added_By] [nvarchar](50) NULL,
	[Added_Date] [datetime] NULL,
	[Last_Updated_By] [nvarchar](50) NULL,
	[Last_Updated_Date] [datetime] NULL,
	[Active_Flag] [nvarchar](1) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Product_Master]    Script Date: 3/23/2017 12:07:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Product_Master](
	[Product_Id] [int] NULL,
	[Category_Id] [int] NULL,
	[Product_Name] [nvarchar](100) NULL,
	[Product_Description] [nvarchar](200) NULL,
	[If_Product_Weight] [numeric](18, 3) NULL,
	[If_Product_Colour] [nvarchar](50) NULL,
	[Product_Price] [money] NULL,
	[Pieces_Per_Unit] [int] NULL,
	[Price_Per_Unit] [money] NULL,
	[Manufactured_By] [nvarchar](50) NULL,
	[Manufactured_Date] [datetime] NULL,
	[Expiry_Date] [datetime] NULL,
	[Quantities_In_Store] [int] NULL,
	[Active_Flag] [nvarchar](1) NULL,
	[Added_By] [nvarchar](50) NULL,
	[Added_Date] [datetime] NULL,
	[Last_Updated_By] [int] NULL,
	[Last_Updated_Date] [datetime] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Shipper_Master]    Script Date: 3/23/2017 12:07:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Shipper_Master](
	[Shipper_Id] [int] NULL,
	[Shipper_Name] [nvarchar](50) NULL,
	[Address] [nvarchar](100) NULL,
	[City] [nvarchar](50) NULL,
	[Zipcode] [numeric](18, 0) NULL,
	[Contact_Person] [nvarchar](50) NULL,
	[Mobile] [numeric](10, 0) NULL,
	[Mail_Id] [nvarchar](50) NULL,
	[FAX] [nvarchar](50) NULL,
	[Licence_Copy] [nvarchar](max) NULL,
	[Active_Flag] [nvarchar](1) NULL,
	[Added_By] [int] NULL,
	[Added_Date] [datetime] NULL,
	[Last_Updated_By] [int] NULL,
	[Last_Updated_Date] [datetime] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Tax_Order]    Script Date: 3/23/2017 12:07:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Tax_Order](
	[Tax_Order_Id] [int] NULL,
	[Tax_Id] [int] NULL,
	[Order_Id] [int] NULL,
	[Amount] [money] NULL,
	[Active_Flag] [nvarchar](1) NULL,
	[Added_By] [int] NULL,
	[Added_Date] [datetime] NULL,
	[Last_Updated_By] [int] NULL,
	[Last_Updated_Date] [datetime] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Taxes_Master]    Script Date: 3/23/2017 12:07:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Taxes_Master](
	[Tax_Id] [int] NULL,
	[Description] [nvarchar](50) NULL,
	[Percentage] [nvarchar](20) NULL,
	[Active_Flag] [nvarchar](1) NULL,
	[Added_By] [int] NULL,
	[Added_Date] [datetime] NULL,
	[Last_Updated_By] [int] NULL,
	[Last_Updated_Date] [datetime] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Transport_By_Courier]    Script Date: 3/23/2017 12:07:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Transport_By_Courier](
	[Courier_Id] [int] NULL,
	[Courier_Name] [nvarchar](50) NULL,
	[POD_No] [nvarchar](50) NULL,
	[Courier_Weight] [numeric](18, 3) NULL,
	[Active_Flag] [nvarchar](1) NULL,
	[Added_By] [int] NULL,
	[Added_Date] [datetime] NULL,
	[Updated_By] [int] NULL,
	[Updated_Date] [datetime] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Transport_By_Hand]    Script Date: 3/23/2017 12:07:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Transport_By_Hand](
	[Transporter_Id] [nchar](10) NULL,
	[Person_Name] [nvarchar](50) NULL,
	[Mobile] [numeric](10, 0) NULL,
	[Photo] [nvarchar](max) NULL,
	[Identity_Proff] [nvarchar](50) NULL,
	[Identity_Proff_Id] [nvarchar](50) NULL,
	[Active_Flag] [nvarchar](1) NULL,
	[Added_By] [int] NULL,
	[Added_Date] [datetime] NULL,
	[Updated_By] [int] NULL,
	[Updated_Date] [datetime] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Transport_By_Vehicle]    Script Date: 3/23/2017 12:07:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Transport_By_Vehicle](
	[Transport_Vehicle_Id] [int] NULL,
	[Transport_Vehicle_Type] [int] NULL,
	[Vehicle_Number] [nvarchar](20) NULL,
	[LR_Number] [nvarchar](50) NULL,
	[Driver_Name] [nvarchar](50) NULL,
	[Mobile] [numeric](10, 0) NULL,
	[Active_Flag] [nvarchar](1) NULL,
	[Added_By] [int] NULL,
	[Added_Date] [datetime] NULL,
	[Updated_By] [int] NULL,
	[Updated_Date] [datetime] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Transportation]    Script Date: 3/23/2017 12:07:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Transportation](
	[Transportation_Id] [int] NULL,
	[Transport_type] [nvarchar](50) NULL,
	[Active_Flag] [nvarchar](1) NULL,
	[Added_By] [int] NULL,
	[Added_Date] [datetime] NULL,
	[Updated_By] [int] NULL,
	[Updated_Date] [datetime] NULL
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Vehicle_Type_Master]    Script Date: 3/23/2017 12:07:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Vehicle_Type_Master](
	[Vehicle_Type_Id] [int] NULL,
	[Description] [nvarchar](50) NULL,
	[Active_Flag] [nvarchar](1) NULL,
	[Added_By] [int] NULL,
	[Added_Date] [datetime] NULL,
	[Updated_By] [int] NULL,
	[Updated_Date] [int] NULL
) ON [PRIMARY]

GO
ALTER TABLE [dbo].[Bill_Master] ADD  DEFAULT (getdate()) FOR [Bill_Date]
GO
ALTER TABLE [dbo].[Cart_Master] ADD  DEFAULT (getdate()) FOR [Order_Date]
GO
