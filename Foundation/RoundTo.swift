extension Double {
    
    func round(to places: Double) -> Double {
        let digit = pow(10, places)
        return floor(self * digit) / digit
    }
}
