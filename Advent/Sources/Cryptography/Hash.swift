
import Crypto
import Foundation

public struct Hash: Equatable, Hashable {

    fileprivate enum Kind: Equatable, Hashable {
        case md5(Insecure.MD5Digest)
    }

    fileprivate let kind: Kind

    public static func md5(_ value: String) -> Self {
        Hash(kind: .md5(Insecure.MD5.hash(data: Data(value.utf8))))
    }
}

extension Hash: CustomStringConvertible {

    public var description: String {
        switch kind {
        case .md5(let digest):
            return digest.map { String(format: "%02x", $0) }.joined()
        }
    }
}
