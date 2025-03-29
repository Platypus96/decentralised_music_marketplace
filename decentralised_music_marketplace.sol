//SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.5.0 <0.9.0;

contract Decentralised_Music_marketplace{

    struct Song{                                      
        string name;                                    
        uint id;                                        // unique id of song (0-n)
        uint price;                                     
        string artistName;                              
        address payable addArtist;                     
    }

    mapping (address => string) public artists; //making a map for the artists    
    mapping (address => string) public listener; // making a map for the listeners

    // 1. {Registration Users}
    event artist_registration(address indexed artist); // indexed used for ease in Etherscan (Event for Artist Registration)
    event listener_registration(address indexed listener); // (Event for Listener registration)

    // Registration -> Artist
    function registerArtists(string memory _name) public {
        require(bytes(artists[msg.sender]).length == 0,"You are already Registered");  // check if artist is already registered
        artists[msg.sender] = _name; 
        emit artist_registration(msg.sender);                                         
    }

    // Registration -> Listener
    function registerListeners(string memory _name) public {
        require(bytes(listener[msg.sender]).length == 0,"You are already Registered"); // check if listener is already registered
        listener[msg.sender] = _name;
        emit listener_registration(msg.sender);                                       
    }
 
    // 2. {Songs Upload}

    uint song_counter; //serves two purpose 1.Act as a unique identifier for song<> 2.We can track the number of songs on the marketplace
    mapping (uint => Song) public songs; //mapping or storage for songs

    event song_uploaded(uint indexed id, address indexed artist, string song_name);

    function songUpload(string memory _name, uint _price, string memory _artistName) public {   //song comes with its name, artist name and price
        require(bytes(artists[msg.sender]).length != 0, "Register as Artist First"); //artist should be first registered             
        song_counter++;                                                                         
        songs[song_counter] = Song(_name,song_counter,_price,_artistName,payable(msg.sender)); //msg.sender at that time is the artist
        emit song_uploaded(song_counter, msg.sender, _name);
    }

    // 3. {Donation}

    event song_donation(address indexed artist, address indexed donor, string message, uint amount);  //Your money and message are safely delivered

    function Donate_Artist(address payable _artist, string memory _message) public payable {
       require(bytes(artists[_artist]).length != 0, "Artist doesn't exist."); // check if artist exists
       (bool success, ) = _artist.call{value: msg.value}("");   // Can use transfer function too  
       require(success, "Transfer failed.");
       emit song_donation(_artist, msg.sender, _message, msg.value);
    }
    
    // 4. {Purchasing a song} [[GOOD PART}}

    mapping (address => mapping(uint => bool)) public songs_purchased; // to track song purchases by user (IMPROVISED With the help of AI what I made was a array to tack the songs owned by a user

    event songPurchasing(address indexed buyer, uint indexed id_Song);

    function BuyA_Song(uint _idSong) public payable {  
        Song storage song = songs[_idSong];  // load the song
        require(_idSong > 0 && _idSong <= song_counter, "Song Not Found");  // ensure song ID is valid
        require(!songs_purchased[msg.sender][_idSong], "You already have this song.");                          
        require(song.price == msg.value, "Check the Price of the Song");  // ensure correct price is paid

        song.addArtist.transfer(msg.value);  // transfer Ether to the artist
        songs_purchased[msg.sender][_idSong] = true;  // mark song as purchased by the buyer

        emit songPurchasing(msg.sender, _idSong);  // emit the purchase event
    }
}
