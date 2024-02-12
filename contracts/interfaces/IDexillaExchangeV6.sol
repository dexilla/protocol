// SPDX-License-Identifier: GPL-2.0-or-later

pragma solidity 0.8.18;

interface IDexillaExchangeV4 {
    function FEE_COLLECTOR_ROLE() external view returns (bytes32);

    function tradeFee() external view returns (uint);

    function totalBaseFee() external view returns (uint);

    function totalQuoteFee() external view returns (uint);

    function BASE_TOKEN_DECIMALS() external view returns (uint8);

    function QUOTE_TOKEN_DECIMALS() external view returns (uint8);

    function baseToken() external view returns (address);

    function quoteToken() external view returns (address);

    function weth() external view returns (address);

    function bids(address, uint) external view returns (uint);

    function asks(address, uint) external view returns (uint);

    function pausedTrading() external view returns (bool);

    /**
     * @param side The side of the order (0 for buy, 1 for sell).
     * @param price The price of the order.
     * @param quantity The quantity of the order.
     * @dev This function is used to create an order. It takes the side, price, and quantity as parameters.
     * @notice DO NOT PASS msg.value MORE THAN THE ACTUAL NEEDED AMOUNT, IT WILL BE LOST FOREVER.
     */
    function createOrder(uint8 side, uint price, uint quantity) external payable;

    /**
     * @param side The side of the order (0 for buy, 1 for sell).
     * @param price The price of the order.
     * @param quantity The quantity of the order.
     * @param allowance The allowance granted by the user to spend their tokens.
     * @param deadline The deadline for the permit signature.
     * @param v The recovery byte of the permit signature.
     * @param r The R part of the permit signature.
     * @param s The S part of the permit signature.
     * @dev This function is used to create an order with a permit, which allows spending the user's tokens.
     * @notice DO NOT PASS msg.value MORE THAN THE ACTUAL NEEDED AMOUNT, IT WILL BE LOST FOREVER.
     */
    function createOrderWithPermit(
        uint8 side,
        uint price,
        uint quantity,
        uint allowance,
        uint deadline,
        uint8 v,
        bytes32 r,
        bytes32 s
    ) external payable;

    /**
     * @param side The side of the order (0 for buy, 1 for sell).
     * @param price The price of the order.
     * @param quantity The quantity of the order.
     * @param allowance The allowance granted by the user to spend their tokens.
     * @param deadline The deadline for the permit signature.
     * @param signature The signature containing the permit data.
     * @dev This function is used to create an order with a permit, which allows spending the user's tokens.
     * @notice DO NOT PASS msg.value MORE THAN THE ACTUAL NEEDED AMOUNT, IT WILL BE LOST FOREVER.
     */
    function createOrderWithPermit2(
        uint8 side,
        uint price,
        uint quantity,
        uint allowance,
        uint deadline,
        bytes calldata signature
    ) external payable;

    /**
     * @param makers The array of maker addresses involved in the order.
     * @param side The side of the order (0 for buy, 1 for sell).
     * @param price The price of the order.
     * @param quantity The quantity of the order.
     * @dev This function is used to execute an order. It takes an array of maker addresses,
     * @notice DO NOT PASS msg.value MORE THAN THE ACTUAL NEEDED AMOUNT, IT WILL BE LOST FOREVER.
     */
    function executeOrder(address[] memory makers, uint8 side, uint price, uint quantity) external payable;

    /**
     * @param makers The array of maker addresses involved in the order.
     * @param side The side of the order (0 for buy, 1 for sell).
     * @param price The price of the order.
     * @param quantity The quantity of the order.
     * @param allowance The allowance granted by the user to spend their tokens.
     * @param deadline The deadline for the permit signature.
     * @param v The recovery byte of the permit signature.
     * @param r The R part of the permit signature.
     * @param s The S part of the permit signature.
     * @dev This function is used to execute an order with a permit, which allows spending the user's tokens.
     * @notice DO NOT PASS msg.value MORE THAN THE ACTUAL NEEDED AMOUNT, IT WILL BE LOST FOREVER.
     */
    function executeOrderWithPermit(
        address[] memory makers,
        uint8 side,
        uint price,
        uint quantity,
        uint allowance,
        uint deadline,
        uint8 v,
        bytes32 r,
        bytes32 s
    ) external payable;

    /**
     * @param makers The array of maker addresses involved in the order.
     * @param side The side of the order (0 for buy, 1 for sell).
     * @param price The price of the order.
     * @param quantity The quantity of the order.
     * @param allowance The allowance granted by the user to spend their tokens.
     * @param deadline The deadline for the permit signature.
     * @param signature The signature containing the permit data.
     * @dev This function is used to execute an order with a permit, which allows spending the user's tokens.
     * @notice DO NOT PASS msg.value MORE THAN THE ACTUAL NEEDED AMOUNT, IT WILL BE LOST FOREVER.
     */
    function executeOrderWithPermit2(
        address[] memory makers,
        uint8 side,
        uint price,
        uint quantity,
        uint allowance,
        uint deadline,
        bytes calldata signature
    ) external payable;

    /**
     * @param side The side of the order (0 for buy, 1 for sell).
     * @param price The price of the order.
     * @param desiredQuantity The desired quantity to adjust the order to.
     * @dev This function is used to adjust the size of an existing order. It takes the side, price,
     * @notice DO NOT PASS msg.value MORE THAN THE ACTUAL NEEDED AMOUNT, IT WILL BE LOST FOREVER.
     */
    function adjustOrderSize(uint8 side, uint price, uint desiredQuantity) external payable;

    /**
     * @param side The side of the order (0 for buy, 1 for sell).
     * @param price The price of the order.
     * @dev This function is used to cancel an existing order. It takes the side and price as parameters.
     */
    function cancelOrder(uint8 side, uint price) external;

    /**
     * @param newTradeFee The new trade fee to be set.
     * @dev This function is used by the default admin role to adjust the trade fee.
     */
    function adjustTradeFee(uint16 newTradeFee) external;

    /**
     * @dev This function is used by the fee collector role to withdraw accumulated fees.
     */
    function withdrawFee() external;

    /**
     * @param state The new state to set for trading (true for paused, false for resumed).
     * @dev This function is used by the default admin role to set the pause state for trading.
     */
    function setPauseTrading(bool state) external;

    function multicall(bytes[] calldata data) external payable returns (bytes[] memory results);

    function selfPermit(address token, uint value, uint deadline, uint8 v, bytes32 r, bytes32 s) external payable;

    function selfPermit2(address token, uint value, uint deadline, bytes calldata signature) external payable;

    /**
     * @dev Returns `true` if `account` has been granted `role`.
     */
    function hasRole(bytes32 role, address account) external view returns (bool);

    /**
     * @dev Returns the admin role that controls `role`. See {grantRole} and
     * {revokeRole}.
     *
     * To change a role's admin, use {AccessControl-_setRoleAdmin}.
     */
    function getRoleAdmin(bytes32 role) external view returns (bytes32);

    /**
     * @dev Grants `role` to `account`.
     *
     * If `account` had not been already granted `role`, emits a {RoleGranted}
     * event.
     *
     * Requirements:
     *
     * - the caller must have ``role``'s admin role.
     */
    function grantRole(bytes32 role, address account) external;

    /**
     * @dev Revokes `role` from `account`.
     *
     * If `account` had been granted `role`, emits a {RoleRevoked} event.
     *
     * Requirements:
     *
     * - the caller must have ``role``'s admin role.
     */
    function revokeRole(bytes32 role, address account) external;

    /**
     * @dev Revokes `role` from the calling account.
     *
     * Roles are often managed via {grantRole} and {revokeRole}: this function's
     * purpose is to provide a mechanism for accounts to lose their privileges
     * if they are compromised (such as when a trusted device is misplaced).
     *
     * If the calling account had been granted `role`, emits a {RoleRevoked}
     * event.
     *
     * Requirements:
     *
     * - the caller must be `account`.
     */
    function renounceRole(bytes32 role, address account) external;
}
