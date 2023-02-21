// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import {ERC721Consecutive} from "@openzeppelin/contracts/token/ERC721/extensions/ERC721Consecutive.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";
import {Base64} from "@openzeppelin/contracts/utils/Base64.sol";
import {Strings} from "@openzeppelin/contracts/utils/Strings.sol";
import {Colours} from "./Colours.sol";
import {BokkyPooBahsDateTimeLibrary} from "./BokkyPooBahsDateTimeLibrary.sol";

contract WeekInEthereumNewsOnchainSVGNFT is ERC721, ERC721Consecutive, Colours, Ownable {
    /// ERRORS

    /// @notice Thrown when attempting to call when not the owner
    error NotTokenOwner();

    /// @notice Thrown when token doesn't exist
    error NonexistentToken();

    /// EVENTS

    string[] months = [
        "January",
        "February",
        "March",
        "April",
        "May",
        "June",
        "July",
        "August",
        "September",
        "October",
        "November",
        "December"
    ];

    string[] monthsLowerCase = [
        "january",
        "february",
        "march",
        "april",
        "may",
        "june",
        "july",
        "august",
        "september",
        "october",
        "november",
        "december"
    ];

    uint256[] issueDate = [
        1471737600,
        1472342400,
        1472947200,
        1473552000,
        1474156800,
        1474761600,
        1475280000,
        1475884800,
        1476576000,
        1477180800,
        1477785600,
        1478390400,
        1479081600,
        1479600000,
        1480204800,
        1480809600,
        1481414400,
        1482019200,
        1482624000,
        1483228800,
        1483833600,
        1484438400,
        1485043200,
        1485648000,
        1486252800,
        1486857600,
        1487462400,
        1488067200,
        1488672000,
        1489276800,
        1489881600,
        1490486400,
        1491091200,
        1491696000,
        1492300800,
        1492905600,
        1493510400,
        1494115200,
        1494720000,
        1495324800,
        1495929600,
        1496534400,
        1497484800,
        1498262400,
        1498953600,
        1499558400,
        1500163200,
        1500768000,
        1501545600,
        1502150400,
        1502668800,
        1503360000,
        1503964800,
        1504483200,
        1505174400,
        1505779200,
        1506384000,
        1507075200,
        1507680000,
        1508284800,
        1508803200,
        1509321600,
        1510099200,
        1510790400,
        1511395200,
        1512000000,
        1512604800,
        1513209600,
        1513814400,
        1514332800,
        1515024000,
        1515628800,
        1516233600,
        1516838400,
        1517443200,
        1518048000,
        1518652800,
        1519257600,
        1519862400,
        1520380800,
        1521072000,
        1521676800,
        1522454400,
        1522886400,
        1523491200,
        1524096000,
        1524700800,
        1525305600,
        1525910400,
        1526515200,
        1527033600,
        1527724800,
        1528329600,
        1528934400,
        1529539200,
        1530144000,
        1530748800,
        1531440000,
        1531958400,
        1532563200,
        1533168000,
        1533772800,
        1534464000,
        1535068800,
        1535673600,
        1536278400,
        1536883200,
        1537488000,
        1538092800,
        1538697600,
        1539302400,
        1539907200,
        1540512000,
        1541203200,
        1541721600,
        1542326400,
        1543017600,
        1543622400,
        1544140800,
        1544745600,
        1545350400,
        1545955200,
        1546560000,
        1547164800,
        1547769600,
        1548374400,
        1548979200,
        1549584000,
        1550188800,
        1550793600,
        1551398400,
        1552003200,
        1552608000,
        1553212800,
        1553817600,
        1554422400,
        1555027200,
        1555632000,
        1556323200,
        1556928000,
        1557446400,
        1558137600,
        1558742400,
        1559347200,
        1559952000,
        1560556800,
        1561161600,
        1561852800,
        1562371200,
        1562976000,
        1563580800,
        1564272000,
        1564790400,
        1565395200,
        1566000000,
        1566604800,
        1567296000,
        1567900800,
        1568505600,
        1569110400,
        1569715200,
        1570233600,
        1570924800,
        1571529600,
        1572134400,
        1572739200,
        1573344000,
        1574035200,
        1574640000,
        1575158400,
        1575763200,
        1576368000,
        1576972800,
        1577491200,
        1578182400,
        1578787200,
        1579392000,
        1579996800,
        1580601600,
        1581206400,
        1581811200,
        1582416000,
        1583107200,
        1583712000,
        1584230400,
        1584748800,
        1585440000,
        1586044800,
        1586736000,
        1587254400,
        1587859200,
        1588464000,
        1589068800,
        1589673600,
        1590278400,
        1590883200,
        1591488000,
        1592092800,
        1592697600,
        1593302400,
        1593907200,
        1594512000,
        1595116800,
        1595721600,
        1596326400,
        1596931200,
        1597536000,
        1598140800,
        1598745600,
        1599350400,
        1599955200,
        1600560000,
        1601164800,
        1601769600,
        1602374400,
        1602979200,
        1603584000,
        1604188800,
        1604793600,
        1605398400,
        1606003200,
        1606608000,
        1607212800,
        1607817600,
        1608422400,
        1609027200,
        1609632000,
        1610236800,
        1610928000,
        1611446400,
        1612137600,
        1612656000,
        1613347200,
        1613952000,
        1614470400,
        1615075200,
        1615680000,
        1616284800,
        1616889600,
        1617494400,
        1618099200,
        1618704000,
        1619395200,
        1620000000,
        1620518400,
        1621123200,
        1621728000,
        1622332800,
        1622937600,
        1623456000,
        1624060800,
        1624665600,
        1625270400,
        1625875200,
        1626480000,
        1627084800,
        1627689600,
        1628380800,
        1628899200,
        1629504000,
        1630108800,
        1630713600,
        1631318400,
        1631923200,
        1632528000,
        1633132800,
        1633737600,
        1634342400,
        1634947200,
        1635552000,
        1636156800,
        1636761600,
        1637366400,
        1637971200,
        1638576000,
        1639180800,
        1639785600,
        1640304000,
        1640908800,
        1641600000,
        1642204800,
        1642809600,
        1643414400,
        1644019200,
        1644624000,
        1645228800,
        1645833600,
        1646438400,
        1647043200,
        1647648000,
        1648252800,
        1648857600,
        1649462400,
        1650067200,
        1650672000,
        1651276800,
        1651881600,
        1652486400,
        1653091200,
        1653696000,
        1654300800,
        1654905600,
        1655510400,
        1656115200,
        1656720000,
        1657324800,
        1657929600,
        1658534400,
        1659139200,
        1659744000,
        1660348800,
        1660953600,
        1661558400,
        1662163200,
        1662768000,
        1663372800,
        1663977600,
        1664582400,
        1665187200,
        1665792000,
        1666396800,
        1667001600,
        1667606400,
        1668211200,
        1668816000,
        1669420800,
        1670025600,
        1670630400,
        1671235200,
        1671840000,
        1672444800,
        1673049600,
        1673654400,
        1674259200,
        1674864000,
        1675468800,
        1676073600,
        1676678400
    ];

    uint256 public totalSupply;

    address constant andrew = 0x77737a65C296012C67F8c7f656d1Df81827c9541;
    address constant evan = 0x059aE37646900CaA1680473d1280246AfCCC3114;

    constructor() ERC721("Week in Ethereum News", "WIEN") {
        totalSupply = issueDate.length;
        _mintConsecutive(evan, 245);
        _mintConsecutive(andrew, 12); // Andrew first issue May 16, 2021
        _mintConsecutive(evan, 1); // Evan vacation cover August 8, 2021
        _mintConsecutive(andrew, 43);
        _mintConsecutive(evan, 1); // Evan vacation cover June 11, 2022
        _mintConsecutive(andrew, 30);
        _mintConsecutive(evan, 1);
        _mintConsecutive(andrew, 5); // Evan vacation cover January 14, 2023
    }

    // TODO support future dates
    function mint(address to) public onlyOwner {
        _mint(to, totalSupply);

        unchecked {
            totalSupply++;
        }
    }

    function _ownerOf(uint256 tokenId) internal view virtual override(ERC721, ERC721Consecutive) returns (address) {
        return super._ownerOf(tokenId);
    }

    function _mint(address to, uint256 tokenId) internal virtual override(ERC721, ERC721Consecutive) {
        super._mint(to, tokenId);
    }

    function _beforeTokenTransfer(address from, address to, uint256 firstTokenId, uint256 batchSize)
        internal
        virtual
        override
    {
        super._beforeTokenTransfer(from, to, firstTokenId, batchSize);
    }

    function _afterTokenTransfer(address from, address to, uint256 firstTokenId, uint256 batchSize)
        internal
        virtual
        override(ERC721, ERC721Consecutive)
    {
        super._afterTokenTransfer(from, to, firstTokenId, batchSize);
    }

    function tokenURI(uint256 tokenId) public view virtual override returns (string memory) {
        if (!_exists(tokenId)) {
            revert NonexistentToken();
        }

        string memory tokenName_ = _generateTokenName(tokenId);
        string memory description = _generateDescription(tokenId);

        string memory image = _generateBase64Image(tokenId);
        string memory attributes = _generateAttributes(tokenId);
        return string.concat(
            "data:application/json;base64,",
            Base64.encode(
                bytes(
                    abi.encodePacked(
                        '{"name":"',
                        tokenName_,
                        '", "description":"',
                        description,
                        '", "image": "data:image/svg+xml;base64,',
                        image,
                        '",',
                        attributes,
                        "}"
                    )
                )
            )
        );
    }

    function _generateTokenName(uint256 tokenId) internal view returns (string memory) {
        return string.concat(_generateIssueDate(tokenId), ". #", Strings.toString(tokenId));
    }

    function _generateIssueUrl(uint256 tokenId) internal view returns (string memory) {
        (uint256 year, uint256 month, uint256 day) = BokkyPooBahsDateTimeLibrary.timestampToDate(issueDate[tokenId]);

        return string.concat(
            "https://weekinethereumnews.com/",
            "week-in-ethereum-news-",
            monthsLowerCase[month - 1],
            "-",
            Strings.toString(day),
            "-",
            Strings.toString(year)
        );
    }

    function _generateIssueDate(uint256 tokenId) internal view returns (string memory) {
        (uint256 year, uint256 month, uint256 day) = BokkyPooBahsDateTimeLibrary.timestampToDate(issueDate[tokenId]);

        return string.concat(months[month - 1], " ", Strings.toString(day), ", ", Strings.toString(year));
    }

    function _generateColourId(uint256 tokenId) internal view returns (uint8) {
        uint256 id = uint256(keccak256(abi.encodePacked("WiEN Colour", address(this), Strings.toString(tokenId))));
        return uint8(id % colours.length);
    }

    function _generateColour(uint256 tokenId) internal view returns (string memory) {
        return colours[_generateColourId(tokenId)];
    }

    function _generateDescription(uint256 tokenId) internal view returns (string memory) {
        return string.concat(
            name(),
            ": ",
            _generateIssueDate(tokenId),
            ". #",
            Strings.toString(tokenId),
            ". ",
            _generateIssueUrl(tokenId)
        );
    }

    function _generateAttributes(uint256 tokenId) internal view returns (string memory) {
        (uint256 year, uint256 month, uint256 day) = BokkyPooBahsDateTimeLibrary.timestampToDate(issueDate[tokenId]);

        string memory attributes = string.concat(
            '{"trait_type": "Year", "value": "',
            Strings.toString(year),
            '"}, {"trait_type": "Month", "value": "',
            months[month - 1],
            '"}, {"trait_type": "Day", "value": "',
            Strings.toString(day),
            '"}, {"trait_type": "Color", "value": "',
            _generateColour(tokenId),
            '"}'
        );

        return string.concat('"attributes": [', attributes, "]");
    }

    function _generateSVG(uint256 tokenId) internal view returns (string memory) {
        // Based on AnchorCertificates
        // https://etherscan.io/address/0x600a4446094c341693c415e6743567b9bfc8a4a8#code#F1#L197
        string memory colourValue = _generateColour(tokenId);

        string memory svg = string.concat(
            '<svg id="week-in-ethereum-news" width="500" height="500" viewBox="0 0 500 500" xmlns="http://www.w3.org/2000/svg" >'
            '<rect x="28" y="28" width="444" height="444" rx="20" fill="',
            colourValue,
            '" fill-opacity=".80"/>'
            '<path d="M28 355h444v97c0 11.046-8.954 20-20 20H48c-11.046 0-20-8.954-20-20v-97Z" fill="#000"/>'
            '<g fill="none" stroke="#000" stroke-width="8" stroke-linecap="round" stroke-linejoin="round">'
            '<path d="m236.975 58-1.857 6.309V247.37l1.857 1.853 84.975-50.229L236.975 58Z"/>'
            '<path d="M236.975 58 152 198.994l84.975 50.229V58Zm0 207.312-1.046 1.275v65.211l1.046 3.055L322 215.109l-85.025 50.203Z"/>'
            '<path d="M236.975 334.852v-69.541L152 215.108l84.975 119.744Zm-.001-85.629 84.974-50.228-84.974-38.624v88.852Zm-84.973-50.228 84.973 50.228v-88.852l-84.973 38.624Z"/>'
            "</g>" '<g class="wienText">' '<text x="50" y="405" class="large">Week in Ethereum News</text>'
            '<text x="50" y="435" class="medium">',
            _generateIssueDate(tokenId),
            "</text>"
            "<style> .wienText {font-family: &quot;Courier New&quot;; fill:white;} .medium {font-size: 24px;} .large {font-size: 30px;} </style>"
            "</g>" "</svg>"
        );

        return svg;
    }

    function _generateBase64Image(uint256 tokenId) internal view returns (string memory) {
        return Base64.encode(bytes(_generateSVG(tokenId)));
    }
}
