SELECT
[Year] 
,[Month] 
,[data_CA_SAP_FADP_qty].[PNC] 
,[Company_Code] 
,[Sales_Org] 
,[Cluster] 
,[Product_Line] 
,[Qty] 
,[Stk]*[Qty] as [Net_sales]
,[Insert_date]
,'SAP FADP' as [Channel] 
   FROM [SupplyPlanning].[dbo].[data_CA_SAP_FADP_qty]
   left join [SupplyPlanning].[dbo].[data_CA_Cluster_mapping] 
	   on [data_CA_SAP_FADP_qty].[Sales_Org] = [data_CA_Cluster_mapping].[Sales_Organization] 
		   Left join [SupplyPlanning].[dbo].[data_CA_Range]  
				on [data_CA_SAP_FADP_qty].[PNC]=[data_CA_Range].[PNC] 
					Left join [SupplyPlanning].[dbo].[data_CA_stk_range]  
						on [data_CA_SAP_FADP_qty].[PNC]=[data_CA_stk_range].[PNC_SAP]
where
--get insert date from last 9-3 months, and enforce correct year and month
--useful if you cant connect multiple conditions into one, like here
([Insert_date]=FORMAT(DATEADD(day, -(day(getdate())-1), DATEADD(month, -6, getdate())), 'yyyy-MM-dd')
	and [Year] = year(DATEADD(month, -6, getdate())) and [Month]=month(DATEADD(month, -6, getdate()))) or

([Insert_date]=FORMAT(DATEADD(day, -(day(getdate())-1), DATEADD(month, -5, getdate())), 'yyyy-MM-dd')
	and [Year] = year(DATEADD(month, -5, getdate())) and [Month]=month(DATEADD(month, -5, getdate()))) or

([Insert_date]=FORMAT(DATEADD(day, -(day(getdate())-1), DATEADD(month, -4, getdate())), 'yyyy-MM-dd')
	and [Year] = year(DATEADD(month, -4, getdate())) and [Month]=month(DATEADD(month, -4, getdate()))) or

([Insert_date]=FORMAT(DATEADD(day, -(day(getdate())-1), DATEADD(month, -3, getdate())), 'yyyy-MM-dd')
	and [Year] = year(DATEADD(month, -3, getdate())) and [Month]=month(DATEADD(month, -3, getdate()))) or

([Insert_date]=FORMAT(DATEADD(day, -(day(getdate())-1), DATEADD(month, -2, getdate())), 'yyyy-MM-dd')
	and [Year] = year(DATEADD(month, -2, getdate())) and [Month]=month(DATEADD(month, -2, getdate()))) or

([Insert_date]=FORMAT(DATEADD(day, -(day(getdate())-1), DATEADD(month, -1, getdate())), 'yyyy-MM-dd'))
