import Foundation


struct AUTH_STATUS {
  static let NOT_FOUND = 0
  static let AUTHENTICATED = 1
  static let INVALID_PASSWORD = -1
  static let INACTIVE = -2
  static let PASSWORD_ALREADY_CREATED = -3
  static let RECOVERY_CODE_EXPIRED = -4
  static let RECOVERY_CODE_ALREADY_USED = -5
  static let ACTIVATION_CODE_EXPIRED = -6
  static let ACTIVATION_CODE_ALREADY_USED = -7
}
