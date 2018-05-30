//
//  GRSteps.swift
//
//  Created by Mahendra on 29/05/18
//  Copyright (c) . All rights reserved.
//

import Foundation
import ObjectMapper

public final class GRSteps: Mappable, NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let startLocation = "start_location"
    static let polyline = "polyline"
    static let endLocation = "end_location"
    static let travelMode = "travel_mode"
    static let distance = "distance"
    static let htmlInstructions = "html_instructions"
    static let maneuver = "maneuver"
    static let duration = "duration"
  }

  // MARK: Properties
  public var startLocation: GRStartLocation?
  public var polyline: GRPolyline?
  public var endLocation: GREndLocation?
  public var travelMode: String?
  public var distance: GRDistance?
  public var htmlInstructions: String?
  public var maneuver: String?
  public var duration: GRDuration?

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
    startLocation <- map[SerializationKeys.startLocation]
    polyline <- map[SerializationKeys.polyline]
    endLocation <- map[SerializationKeys.endLocation]
    travelMode <- map[SerializationKeys.travelMode]
    distance <- map[SerializationKeys.distance]
    htmlInstructions <- map[SerializationKeys.htmlInstructions]
    maneuver <- map[SerializationKeys.maneuver]
    duration <- map[SerializationKeys.duration]
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = startLocation { dictionary[SerializationKeys.startLocation] = value.dictionaryRepresentation() }
    if let value = polyline { dictionary[SerializationKeys.polyline] = value.dictionaryRepresentation() }
    if let value = endLocation { dictionary[SerializationKeys.endLocation] = value.dictionaryRepresentation() }
    if let value = travelMode { dictionary[SerializationKeys.travelMode] = value }
    if let value = distance { dictionary[SerializationKeys.distance] = value.dictionaryRepresentation() }
    if let value = htmlInstructions { dictionary[SerializationKeys.htmlInstructions] = value }
    if let value = maneuver { dictionary[SerializationKeys.maneuver] = value }
    if let value = duration { dictionary[SerializationKeys.duration] = value.dictionaryRepresentation() }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.startLocation = aDecoder.decodeObject(forKey: SerializationKeys.startLocation) as? GRStartLocation
    self.polyline = aDecoder.decodeObject(forKey: SerializationKeys.polyline) as? GRPolyline
    self.endLocation = aDecoder.decodeObject(forKey: SerializationKeys.endLocation) as? GREndLocation
    self.travelMode = aDecoder.decodeObject(forKey: SerializationKeys.travelMode) as? String
    self.distance = aDecoder.decodeObject(forKey: SerializationKeys.distance) as? GRDistance
    self.htmlInstructions = aDecoder.decodeObject(forKey: SerializationKeys.htmlInstructions) as? String
    self.maneuver = aDecoder.decodeObject(forKey: SerializationKeys.maneuver) as? String
    self.duration = aDecoder.decodeObject(forKey: SerializationKeys.duration) as? GRDuration
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(startLocation, forKey: SerializationKeys.startLocation)
    aCoder.encode(polyline, forKey: SerializationKeys.polyline)
    aCoder.encode(endLocation, forKey: SerializationKeys.endLocation)
    aCoder.encode(travelMode, forKey: SerializationKeys.travelMode)
    aCoder.encode(distance, forKey: SerializationKeys.distance)
    aCoder.encode(htmlInstructions, forKey: SerializationKeys.htmlInstructions)
    aCoder.encode(maneuver, forKey: SerializationKeys.maneuver)
    aCoder.encode(duration, forKey: SerializationKeys.duration)
  }

}
