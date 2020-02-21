use ReportServer
go

with VarBinMax as ( 
    select 
         ItemID
        ,VarBinMax    = CONVERT(VARBINARY(MAX),[Content],1)
        ,HasBom       = CONVERT(BIT,IIF(
                        LEFT(CONVERT(VARBINARY(MAX),[Content],1),3)=0xEFBBBF,1,0))
        ,LenVarBinMax = LEN(CONVERT(VARBINARY(MAX),[Content],1))
        ,[Type]
    from [Catalog]
    where [Type] = 2
) -- select top(10) * from VarBinMax
, ContentNoBom as (
    select 
         ItemID
        ,ContentNoBom = CONVERT(VARBINARY(max),
                        IIF(HasBom=1,SUBSTRING(VarBinMax,4,LenVarBinMax),VarBinMax))
    from VarBinMax
)  
--select top(10) * from ContentNoBom
select 
     ItemID
    ,RdlXml  = CONVERT(XML,ContentNoBom)
    ,RdlText = CONVERT(NVARCHAR(MAX),CONVERT(XML,ContentNoBom))
into #RDL
from ContentNoBom cnb

select * 
from #RDL
