# HazChain: Blockchain-Based Specialized Logistics for Hazardous Materials

![HazChain Logo](https://via.placeholder.com/150x150)

## Overview

HazChain is a comprehensive blockchain solution designed specifically for the specialized logistics requirements of hazardous materials transportation. By leveraging the immutability, transparency, and security of blockchain technology, HazChain ensures compliance with regulatory requirements while optimizing the safety and efficiency of dangerous goods transport.

## Core Features

HazChain implements a suite of smart contracts that govern the entire hazardous materials logistics process:

### 1. Shipper Verification Contract
- Validates authorized handlers of dangerous goods
- Maintains immutable records of certification and training
- Verifies sender and receiver authorization levels
- Timestamps all verification activities for audit trails

### 2. Material Classification Contract
- Records detailed hazard categories according to international standards
- Documents handling requirements and safety procedures
- Links to regulatory documentation
- Enables automatic identification of compatible/incompatible materials

### 3. Route Approval Contract
- Validates permitted transportation paths based on material classifications
- Records authorized routes with geographical restrictions
- Implements real-time route monitoring and validation
- Provides deviation alerts and contingency routing

### 4. Incident Response Contract
- Manages emergency protocols and procedures
- Automates notification chains to relevant authorities
- Coordinates response resources based on incident type and location
- Creates immutable incident reports for future analysis and improvements

### 5. Compliance Verification Contract
- Ensures adherence to local, national, and international regulations
- Generates compliance reports for regulatory bodies
- Maintains audit-ready documentation
- Adapts to regulatory changes through governance mechanisms

## Technical Architecture

HazChain is built on a modular architecture featuring:

- **Ethereum-compatible blockchain** for smart contract deployment
- **IPFS integration** for documentation storage and retrieval
- **Zero-knowledge proofs** for sensitive data protection while ensuring verification
- **Oracle services** for real-time data feeds from external sources
- **Role-based access control** system with multi-signature authorizations

## Getting Started

### Prerequisites
- Node.js (v14+)
- Truffle Suite or Hardhat
- MetaMask or compatible Web3 provider
- Docker (optional, for containerized deployment)

### Installation

1. Clone the repository:
```bash
git clone https://github.com/yourorganization/hazchain.git
cd hazchain
```

2. Install dependencies:
```bash
npm install
```

3. Configure environment variables:
```bash
cp .env.example .env
# Edit .env with your specific configuration
```

4. Compile smart contracts:
```bash
truffle compile
# or
npx hardhat compile
```

5. Deploy to desired network:
```bash
truffle migrate --network <network_name>
# or
npx hardhat run scripts/deploy.js --network <network_name>
```

## Usage Examples

### Registering a New Hazardous Materials Shipper

```javascript
const ShipperVerification = artifacts.require("ShipperVerification");

module.exports = async function(callback) {
  try {
    const shipperContract = await ShipperVerification.deployed();
    
    // Register new shipper with credentials and certification
    await shipperContract.registerShipper(
      "0xShipperAddress",
      "CERTIFICATION_ID",
      "HAZMAT_CLASS_AUTHORIZATION",
      Date.now() + (365 * 24 * 60 * 60 * 1000) // Expiration one year from now
    );
    
    console.log("Shipper successfully registered");
    callback();
  } catch (error) {
    console.error(error);
    callback(error);
  }
};
```

### Creating a New Hazardous Material Transport Request

```javascript
const MaterialClassification = artifacts.require("MaterialClassification");
const RouteApproval = artifacts.require("RouteApproval");

module.exports = async function(callback) {
  try {
    const materialContract = await MaterialClassification.deployed();
    const routeContract = await RouteApproval.deployed();
    
    // Classify material
    const materialId = await materialContract.classifyMaterial(
      "UN1203", // UN Number for Gasoline
      "3",      // Hazard class
      "II",     // Packing group
      "{\"flash_point\":\"<-40°C\",\"boiling_point\":\">35°C\"}" // Additional properties
    );
    
    // Create route request
    const routeId = await routeContract.createRouteRequest(
      materialId,
      "0xOriginLocation",
      "0xDestinationLocation",
      [waypoint1, waypoint2, waypoint3], // Array of approved waypoints
      startTime,
      estimatedArrival
    );
    
    console.log(`Route created with ID: ${routeId}`);
    callback();
  } catch (error) {
    console.error(error);
    callback(error);
  }
};
```

## Integration with Existing Systems

HazChain provides API endpoints for integration with:

- Transportation Management Systems (TMS)
- Warehouse Management Systems (WMS)
- Enterprise Resource Planning (ERP) solutions
- IoT devices and sensors
- Regulatory reporting systems

Our RESTful API and GraphQL endpoints enable seamless data exchange while maintaining the security and integrity of the blockchain backend.

## Security Considerations

HazChain implements multiple layers of security:

- Multi-signature requirements for critical operations
- Formal verification of smart contracts
- Regular security audits by third-party experts
- Encrypted communication channels
- Secure key management solutions

## Regulatory Compliance

The system is designed to meet or exceed requirements from:

- Department of Transportation (DOT)
- Environmental Protection Agency (EPA)
- Occupational Safety and Health Administration (OSHA)
- International Air Transport Association (IATA)
- International Maritime Dangerous Goods (IMDG) Code
- European Agreement concerning the International Carriage of Dangerous Goods by Road (ADR)

## Contributing

We welcome contributions to HazChain! Please see our [CONTRIBUTING.md](./CONTRIBUTING.md) file for guidelines.

## License

HazChain is released under the [MIT License](./LICENSE).

## Contact

For questions, support, or partnership inquiries:

- Email: contact@hazchain.io
- Website: https://www.hazchain.io
- Discord: [Join our server](https://discord.gg/hazchain)

---

© 2025 HazChain Project. All Rights Reserved.
