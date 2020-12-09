
public prefix func !<Input>(_ f: @escaping (Input) -> Bool) -> (Input) -> Bool {
    { input in !f(input) }
}
