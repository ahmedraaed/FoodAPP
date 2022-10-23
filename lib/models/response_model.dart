class ResponseModel
{
  bool _isSuccsessed;
  String _message;

  ResponseModel(this._isSuccsessed,this._message);

  bool get isSuccsessed  =>_isSuccsessed;
  String get message=>_message;
}