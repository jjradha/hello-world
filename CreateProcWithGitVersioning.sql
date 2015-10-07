﻿use <DbName,,>
go

if exists ( select * 
			from sys.objects 
			where [object_id] = object_id( N'<schemaName,,>.<procName,,>' ) and 
				[type] in ( N'P' ) )
begin
	drop proc <schemaName,,>.<procName,,> ;
	print 'Dropped proc <schemaName,,>.<procName,,> SUCCESSFULLY! At time ' + convert( varchar, getdate(), 126 ) ;
end ;
go

create proc <schemaName,,>.<procName,,>
	@<param1,,> <dataType1,,>
as
/* who				when			what
petervandivier		
*/
begin
	set nocount on;
	set tran isolation level read uncommitted ;

	return 0 ;
end ;

/*
declare 
	@<param1,,> <dataType1,,> = ;

exec <schemaName,,>.<procName,,> 
	@<param1,,> ;
*/

go

if exists ( select * 
			from sys.objects 
			where [object_id] = object_id( N'<schemaName,,>.<procName,,>' ) and 
				[type] in ( N'P' ) )
begin
	print 'Created proc <schemaName,,>.<procName,,> SUCCESSFULLY! At time ' + convert( varchar, getdate(), 126 ) ;
end ;
go