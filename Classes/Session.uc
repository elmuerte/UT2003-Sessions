class Session extends Object;

struct export KeyValuePair
{
    var string Key;
    var string Value;
};

// contains the unique identifier
var string hash;
// contains the data for this session
var array<KeyValuePair> Data;

function string getValue(string name, optional string sdefault)
{
  local int i;
  for (i = 0; i<data.length; i++)
  {
    if (data[i].key == name) return data[i].value;
  }
  return sdefault;
}

function bool setValue(string name, string value, bool bAddIfNotExists, optional out string oldValue)
{
  local int i;
  for (i = 0; i<data.length; i++)
  {
    if (data[i].key == name) 
    {
      oldValue = data[i].value;
      data[i].value = value;
      return true;
    }
  }
  if (bAddIfNotExists)
  {
    data.length = data.length+1;
    data[data.length-1].Key = name;
    data[data.length-1].Value = value;
    return true;
  }
  return false;
}