class Sessions extends Object;

var array<Session> sessions;

// create a new session
function Session createSession()
{
  sessions.length = sessions.length+1;
  sessions[sessions.length-1] = new(None) class'Session';
  sessions[sessions.length-1].Hash = createSessionHash();
  return sessions[sessions.length-1];
}

// get a session by it's hash
function Session getSession(string hash, optional bool bCreateNew)
{
  local int i;
  for (i = 0; i < sessions.length; i++)
  {
    if (sessions[i].Hash == hash) return sessions[i];
  }
  if (bCreateNew) return createSession();
  return none;
}

// destroy an existing session
function bool destroySession(Session session)
{
  local int i;
  for (i = 0; i < sessions.length; i++)
  {
    if (sessions[i].Hash == session.Hash) 
    {
      sessions.Remove(i, 1);
      return true;
    }
  }
  return false;
}

// create a unique session hash
function private string createSessionHash()
{
  local int i;
  local string temphash;

  do {
    temphash = Right("00000"$string(Rand(65536)), 5)$Right("00000"$string(Rand(65536)), 5);
    for (i = 0; i < sessions.length; i++)
    {
      if (sessions[i].hash == temphash) break;
    }
  } until (i == sessions.length);
  return temphash;
}