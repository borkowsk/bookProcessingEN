/// Agent is a one of two central class of each ABM model
//*////////////////////////////////////////////////////////////////

int Number_of_identities=2; ///< How many mutually exclusive identities are there

/// Sakoda inspired type of agent 
class Agent {
  float identity; //!< [1..Number_of_identities]
  float stress;   //!< Stress in current position [0..1]
  
  /// Constructor of the Agent
  Agent() 
  {
    identity=round(random(1,Number_of_identities)); //They must be the same ones sometimes
    stress=0;
  }
}//_endOfClass

//*/////////////////////////////////////////////////////////////////////////////////////////
/// @author https://www.researchgate.net/profile/WOJCIECH_BORKOWSKI @src: ABM: AGENT OF SAKODA MODEL
/// @date 2026 ( → https://github.com/borkowsk/bookProcessingEN 
//*/////////////////////////////////////////////////////////////////////////////////////////
