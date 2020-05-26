import Foundation

class SyringePumpContoller {
    let communicator: SyringePumpCommunicator
    
    var pumpRate = PumpRate.microLiterPerHour {
        didSet {
            
        }
    }
    var rate = 0.0 {
        didSet {
            if rate != oldValue {
                self.setRate(rate: String(rate), units: self.pumpRate)
            }
        }
    }
    
    
    init(port: String) {
        communicator = SyringePumpCommunicator(port: port)
    }
}

// MARK: - Functions
extension SyringePumpContoller {
    
    enum PumpRate: String{
        case microLiterPerMinute = "UM"
        case milliLiterPerMinute = "MM"
        case microLiterPerHour = "UH"
        case milliLiterPerHour = "MH"
    }
    
    enum PumpDirection: String {
        case withdraw = "WDR"
        case infuse = "INF"
    }
    
        
    /**
     Set inside diameter of syringe in mm. Set is only valid when the Pumping Program is not operating. Setting the syringe diameter also sets the units for “Volume to be Dispensed” and “Volume Dispensed”.
     Valid syringe diameters are from 0.1 mm to 50.0 mm.
    
    */
    func setDiameter(of diameter: String){
        communicator.write(command: "DIA\(diameter)")
    }
    
    func getDiameter() -> String {
        communicator.write(command: "DIA")
        return communicator.tempStr
    }
        
    func setRate(rate: String, units: PumpRate){
        communicator.write(command: "FUNRAT")
        communicator.write(command: "RAT\(rate)\(units.rawValue)")
    }
    
    func getRate() -> String{
        communicator.write(command: "FUNRAT")
        communicator.write(command: "RAT")
        return communicator.tempStr
    }
    
    
    func setDirection(of direction: PumpDirection){
        communicator.write(command: "DIR\(direction.rawValue)")
    }
    
    func run(){
        communicator.write(command: "RUN")
    }
    
    func pause(){
        communicator.write(command: "STP")
    }
    
    func stop(){
        communicator.write(command: "FUNSTP")
    }
    
    func getVolDispensed() -> String {
        communicator.write(command: "DIS")
        return communicator.tempStr
    }
}
