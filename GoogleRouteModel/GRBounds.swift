//
//  GRBounds.swift
//
//  Created by Mahendra on 29/05/18
//  Copyright (c) . All rights reserved.
//

import Foundation
import ObjectMapper

public final class GRBounds: Mappable, NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let northeast = "northeast"
    static let southwest = "southwest"
  }

  // MARK: Properties
  public var northeast: GRNortheast?
  public var southwest: GRSouthwest?

  // MARK: ObjectMapper Initializers
  /// Map a JSON object to this class using ObjectMapper.
  ///
  /// - parameter map: A mapping from ObjectMapper.
  public required init?(map: Map){

  }

  /// Map a JSON object to this class using ObjectMapper.
  ///
  /// - parameter map: A mapping from ObjectMapper.
  public func mapping(map: Map) {
    northeast <- map[SerializationKeys.northeast]
    southwest <- map[SerializationKeys.southwest]
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = northeast { dictionary[SerializationKeys.northeast] = value.dictionaryRepresentation() }
    if let value = southwest { dictionary[SerializationKeys.southwest] = value.dictionaryRepresentation() }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.northeast = aDecoder.decodeObject(forKey: SerializationKeys.northeast) as? GRNortheast
    self.southwest = aDecoder.decodeObject(forKey: SerializationKeys.southwest) as? GRSouthwest
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(northeast, forKey: SerializationKeys.northeast)
    aCoder.encode(southwest, forKey: SerializationKeys.southwest)
  }

}
