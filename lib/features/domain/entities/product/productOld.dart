import 'package:json_annotation/json_annotation.dart';
import 'package:gbjatolye/features/domain/entities/product/productOld.dart';

part 'product.g.dart';

@JsonSerializable()
class ProductRequest {
	String page;
	String subtype;
	String jewelrytypeid;
	String collectionGroupId;

	ProductRequest({
		this.page,
		this.subtype,
		this.jewelrytypeid,
		this.collectionGroupId
	});

	Map<String, dynamic> toJson() => _$ProductRequestToJson(this);

}

@JsonSerializable()
class ProductOldResponse {

	List<ProductOld> productlist;
	bool success;
	String message;
	int pagecount;
	int recordcount;

	ProductOldResponse(this.productlist, this.success, this.message, this.pagecount,
			this.recordcount);

	factory ProductOldResponse.fromJson(Map<String, dynamic> json) =>
			_$ProductResponseFromJson(json);
}

@JsonSerializable()
class ProductOld {
	int id;
	String createdate;
	String updatedate;
	String productcode;
	String boxno;
	String moldno;
	double weight;
	int costtypeid;
	double percost;
	double totalcost;
	bool isactive;
	int productstatusid;
	int supplierid;
	String description;
	bool ispackage;
	double salesprice;
	String title;
	int packagequantity;
	int stockquantity;
	bool iscompleted;
	double vatpercentage;
	int likecount;
	int currencyid;
	int profitrateid;
	int minimumorderquantity;
	List<String> imagelist;
	List<SizeGroup> sizes;
	List<SpecificationGroup> specifications;
	bool selected = false;

	ProductOld(
			{this.id,
				this.createdate,
				this.updatedate,
				this.productcode,
				this.boxno,
				this.moldno,
				this.weight,
				this.costtypeid,
				this.percost,
				this.totalcost,
				this.isactive,
				this.productstatusid,
				this.supplierid,
				this.description,
				this.ispackage,
				this.packagequantity,
				this.stockquantity,
				this.iscompleted,
				this.vatpercentage,
				this.currencyid,
				this.profitrateid,
				this.minimumorderquantity,
				this.imagelist,
				this.likecount,
				this.salesprice,
				this.sizes,
				this.specifications,
				this.title
			});

	factory ProductOld.fromJson(Map<String, dynamic> json) =>
			_$ProductFromJson(json);
}


///Specs
@JsonSerializable()
class SpecificationGroup {
	int titleid;
	String titlename;
	bool multiselect;
	List <Specification> specifications;

	SpecificationGroup({this.titleid, this.titlename,this.multiselect,this.specifications});

	factory SpecificationGroup.fromJson(Map<String, dynamic> json) =>
			_$SpecificationGroupFromJson(json);

}

@JsonSerializable()
class Specification {

	int id;
	String name;
	String icon;
	bool selected;

	Specification({this.id, this.name,this.selected,this.icon});

	factory Specification.fromJson(Map<String, dynamic> json) =>
			_$SpecificationFromJson(json);

}

///Options
@JsonSerializable()
class SizeGroup {
	String sizetitlename;
	List<Size> sizes;
	bool isdefault;

	SizeGroup({this.sizetitlename, this.sizes,this.isdefault});

	factory SizeGroup.fromJson(Map<String, dynamic> json) =>
			_$SizeGroupFromJson(json);
}

@JsonSerializable()
class Size {
	int sizeid;
	String name;
	bool selected;

	Size({this.sizeid, this.name, this.selected});

	factory Size.fromJson(Map<String, dynamic> json) => _$SizeFromJson(json);
}

