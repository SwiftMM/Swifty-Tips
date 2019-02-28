extension TimeInterval {
    
    public func countdown(
        repeating: TimeInterval = 1,
        executing: @escaping (TimeInterval) -> Void,
        completion: @escaping () -> Void)
        -> DispatchSourceTimer
    {
        let timer = DispatchSource.makeTimerSource()
        timer.schedule(wallDeadline: .now(), repeating: repeating)
        
        var timeout = self
        timer.setEventHandler {
            timeout -= repeating
            
            guard timeout >= 1 else {
                timer.cancel()
                DispatchQueue.main.async { completion() }
                return
            }
            
            DispatchQueue.main.async { executing(timeout) }
        }
        timer.resume()
        
        return timer
    }
}

extension Int {
    
    public func countdown(
        repeating: TimeInterval = 1,
        executing: @escaping (TimeInterval) -> Void,
        completion: @escaping () -> Void)
        -> DispatchSourceTimer
    {
        return TimeInterval(self).countdown(
            repeating: repeating,
            executing: executing,
            completion: completion)
    }
}
