;; Compliance Verification Contract
;; Ensures adherence to regulations

(define-data-var admin principal tx-sender)

;; Map to store regulatory requirements
(define-map regulations uint
  {
    title: (string-utf8 128),
    description: (string-utf8 512),
    applicable-hazard-classes: (list 10 uint),
    version: uint,
    effective-block: uint
  }
)

;; Map to store compliance verifications
(define-map compliance-verifications
  {
    shipment-id: (string-utf8 128),
    regulation-id: uint
  }
  {
    verified: bool,
    verifier: principal,
    verification-block: uint,
    verification-data: (string-utf8 512)
  }
)

;; Public function to define a regulation
(define-public (define-regulation
    (regulation-id uint)
    (title (string-utf8 128))
    (description (string-utf8 512))
    (applicable-hazard-classes (list 10 uint))
    (version uint)
    (effective-block uint)
  )
  (begin
    (asserts! (is-eq tx-sender (var-get admin)) (err u1)) ;; Only admin can define regulations
    (ok (map-set regulations regulation-id
      {
        title: title,
        description: description,
        applicable-hazard-classes: applicable-hazard-classes,
        version: version,
        effective-block: effective-block
      }
    ))
  )
)

;; Public function to verify compliance
(define-public (verify-compliance
    (shipment-id (string-utf8 128))
    (regulation-id uint)
    (verification-data (string-utf8 512))
  )
  (let ((regulation (map-get? regulations regulation-id)))
    (begin
      (asserts! (is-some regulation) (err u404)) ;; Regulation must exist
      (ok (map-set compliance-verifications
        {
          shipment-id: shipment-id,
          regulation-id: regulation-id
        }
        {
          verified: true,
          verifier: tx-sender,
          verification-block: block-height,
          verification-data: verification-data
        }
      ))
    )
  )
)

;; Public function to check compliance
(define-read-only (is-compliant
    (shipment-id (string-utf8 128))
    (regulation-id uint)
  )
  (map-get? compliance-verifications
    {
      shipment-id: shipment-id,
      regulation-id: regulation-id
    }
  )
)

;; Public function to get regulation details
(define-read-only (get-regulation (regulation-id uint))
  (map-get? regulations regulation-id)
)

;; Admin functions
(define-public (set-admin (new-admin principal))
  (begin
    (asserts! (is-eq tx-sender (var-get admin)) (err u100))
    (ok (var-set admin new-admin))
  )
)
