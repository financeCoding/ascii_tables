library ascii_tables;

part 'src/format_string.dart';
part 'src/exceptions.dart';
part 'src/from_types.dart';
part 'src/header_builder.dart';
part 'src/body_builder.dart';
part 'src/table_measure.dart';

const PAD_RIGHT = 1;
const PAD_LEFT = 2;
const PAD_BOTH = 3;


class ascii_tables{
  
  
  bool _isPrintHeaderEnabled = true;
  String _tableHeaderString;
  String _tableBodyString;
  int _padding = 1;
  int _from_type;
  Map <String, int> _column_sizes;
  
  
  Map <String, Map <String, String>> _content_map = new Map();

  
  
  HeaderBuilder _hb = new HeaderBuilder();
  BodyBuilder _bb = new BodyBuilder();
  TableMeasure _tm = new TableMeasure();
  
  ascii_tables.fromMap(Map <String, Map <String, String>> map){
    this._content_map = map;
    this._column_sizes = this._tm.fromMap(map);
  }
  
  ascii_tables.fromList(List <Map <String, String>> list) {
    this._content_map = new Map.fromIterable(list);
    this._column_sizes = this._tm.fromMap(this._content_map);
  }
  
  ascii_tables.fromSet(Set set) {

  }

  ascii_tables.fromIterator(Iterator <String> i){

  }  
  
  void displayHeader(bool display_header) {
    this._isPrintHeaderEnabled = display_header;
  }
  
  void setPadding(int padding){
    this._padding = padding;
  }
  
  void printTable() {
    print(this._makeTable());
  }
  
  String returnTable() {
    return this._makeTable();
  }
  
  String _makeTable() {
    String table = '';
      this._hb.setPadding(this._padding);
      this._bb.setPadding(this._padding);
      this._hb.setColumnSizes(this._column_sizes);
      this._bb.setColumnSizes(this._column_sizes);
      this._tableHeaderString = this._hb.fromMap(this._content_map);
      this._tableBodyString = this._bb.fromMap(this._content_map);
    
    
    FormatString fs = new FormatString();
    
    int total_length = this._column_sizes.length * 2 * this._padding;
    this._column_sizes.forEach((k,v) {
      total_length += v;
    });
    total_length += (this._column_sizes.length -1);    
    table += '+' + fs.str_repeat('-', total_length) + '+\n';    
    if(this._isPrintHeaderEnabled){
      table += this._tableHeaderString + '\n';
    }
      table += this._tableBodyString + '\n';
      table += '+' + fs.str_repeat('-', total_length) + '+';
      return table;
  }  
}