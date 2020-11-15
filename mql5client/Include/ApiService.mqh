#property copyright "Copyright © 2006-2017"
#property version "1.12"
#property strict

#include <JAson.mqh>
#include <RestClient.mqh>
#include <Structures.mqh>


class ApiService
  {

   RestClient *      _restClient;

   CJAVal *          _jsonParser;

   string            _strategy;

   string            _advisor_id;

   string            _symbol;

public:
                     ApiService(long magic, string symbol, string strategy)
     {
      RestConfig config = { "http://127.0.0.1", 80, "Content-Type: application/json\r\n", 3000 };
      _restClient = new RestClient(magic, symbol, config);
      _jsonParser = new CJAVal(NULL, jtUNDEF);
      _strategy = strategy;
      _symbol = symbol;
     }
                    ~ApiService() { delete _restClient; delete _jsonParser; }

public:

   string             Connect(string inputs)
     {
      string responceBody = _restClient.Connect(inputs);
      _jsonParser.Clear();
      _jsonParser.Deserialize(responceBody);
      return _advisor_id = _jsonParser["id"].ToStr();
     }

   void                 GetSignal(Signal &signal)
     {
      string responceBody = _restClient.GetSignal(_advisor_id, _strategy);
      _jsonParser.Clear();
      _jsonParser.Deserialize(responceBody);
      signal.lot = _jsonParser["lot"].ToDbl();
      signal.type = (SignalType) _jsonParser["type"].ToStr();
      signal.advisorId = _jsonParser["id"].ToStr();
      signal.stopLoss = (int) _jsonParser["stopLoss"].ToInt();
      signal.takeProfit = (int) _jsonParser["takeProfit"].ToInt();
      signal.positionId = _jsonParser["positionId"].ToInt();
     }

  };