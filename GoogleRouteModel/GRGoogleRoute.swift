//
//  GRGoogleRoute.swift
//
//  Created by Mahendra on 29/05/18
//  Copyright (c) . All rights reserved.
//

import Foundation
import ObjectMapper

public final class GRGoogleRoute: Mappable, NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let status = "status"
    static let routes = "routes"
    static let geocodedWaypoints = "geocoded_waypoints"
  }

  // MARK: Properties
  public var status: String?
  public var routes: [GRRoutes]?
  public var geocodedWaypoints: [GRGeocodedWaypoints]?

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
    status <- map[SerializationKeys.status]
    routes <- map[SerializationKeys.routes]
    geocodedWaypoints <- map[SerializationKeys.geocodedWaypoints]
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = status { dictionary[SerializationKeys.status] = value }
    if let value = routes { dictionary[SerializationKeys.routes] = value.map { $0.dictionaryRepresentation() } }
    if let value = geocodedWaypoints { dictionary[SerializationKeys.geocodedWaypoints] = value.map { $0.dictionaryRepresentation() } }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.status = aDecoder.decodeObject(forKey: SerializationKeys.status) as? String
    self.routes = aDecoder.decodeObject(forKey: SerializationKeys.routes) as? [GRRoutes]
    self.geocodedWaypoints = aDecoder.decodeObject(forKey: SerializationKeys.geocodedWaypoints) as? [GRGeocodedWaypoints]
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(status, forKey: SerializationKeys.status)
    aCoder.encode(routes, forKey: SerializationKeys.routes)
    aCoder.encode(geocodedWaypoints, forKey: SerializationKeys.geocodedWaypoints)
  }

}
