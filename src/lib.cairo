use core::starknet::ContractAddress;

#[starknet::interface]
pub trait IRewardSystem<TContractState> {
    fn add_points(ref self: TContractState, user: ContractAddress, points: felt252);
    fn redeem_points(ref self: TContractState, user: ContractAddress, points: felt252);
    fn get_balance(self: @TContractState, user: ContractAddress) -> felt252;
}

#[starknet::contract]
mod RewardSystem {
    use core::starknet::{ContractAddress, get_caller_address};
    use core::starknet::storage::{Map, StoragePathEntry, StoragePointerReadAccess, StoragePointerWriteAccess};

    #[storage]
    struct Storage {
        balances: Map::<ContractAddress, felt252>,
    }

    #[event]
    #[derive(Drop, starknet::Event)]
    enum Event {
        PointsAdded: PointsAdded,
        PointsRedeemed: PointsRedeemed,
    }

    #[derive(Drop, starknet::Event)]
    struct PointsAdded {
        #[key]
        user: ContractAddress,
        points: felt252,
    }

    #[derive(Drop, starknet::Event)]
    struct PointsRedeemed {
        #[key]
        user: ContractAddress,
        points: felt252,
    }
    use core::starknet::ContractAddress;

    #[starknet::interface]
    pub trait IRewardSystem<TContractState> {
        fn add_points(ref self: TContractState, user: ContractAddress, points: felt252);
        fn redeem_points(ref self: TContractState, user: ContractAddress, points: felt252);
        fn get_balance(self: @TContractState, user: ContractAddress) -> felt252;
    }
    
    #[starknet::contract]
    mod RewardSystem {
        use core::starknet::{ContractAddress};
        use core::starknet::storage::{Map};
    
        #[storage]
        struct Storage {
            balances: Map::<ContractAddress, felt252>,
        }
    
        #[event]
        #[derive(Drop, starknet::Event)]
        enum Event {
            PointsAdded: PointsAdded,
            PointsRedeemed: PointsRedeemed,
        }
    
        #[derive(Drop, starknet::Event)]
        struct PointsAdded {
            #[key] user: ContractAddress,
            points: felt252,
        }
    
        #[derive(Drop, starknet::Event)]
        struct PointsRedeemed {
            #[key] user: ContractAddress,
            points: felt252,
        }
    
        #[constructor]
        fn constructor(ref self: ContractState) {
            // Optionally initialize a balance if required, otherwise, remove this line.
        }
    
        #[abi(embed_v0)]
        impl RewardSystem of super::IRewardSystem<ContractState> {
            fn add_points(ref self: ContractState, user: ContractAddress, points: felt252) {
                let current_balance = self.balances.entry(user).read();
                self.balances.entry(user).write(current_balance + points);
                self.emit(PointsAdded { user: user, points: points });
            }
    
            fn redeem_points(ref self: ContractState, user: ContractAddress, points: felt252) {
                let current_balance = self.balances.entry(user).read();
                // Adjust this line if a comparison utility is available, or cast types if necessary.
                assert(current_balance >= points, "Insufficient balance");
                self.balances.entry(user).write(current_balance - points);
                self.emit(PointsRedeemed { user: user, points: points });
            }
    
            fn get_balance(self: @ContractState, user: ContractAddress) -> felt252 {
                self.balances.entry(user).read()
            }
        }
    }
    
    #[constructor]
    fn constructor(ref self: ContractState) {
        self.balances.write();
    }

    #[abi(embed_v0)]
    impl RewardSystem of super::IRewardSystem<ContractState> {
        fn add_points(ref self: ContractState, user: ContractAddress, points: felt252) {
            let current_balance = self.balances.entry(user).read();
            self.balances.entry(user).write(current_balance + points);
            self.emit(PointsAdded { user: user, points: points });
        }

        fn redeem_points(ref self: ContractState, user: ContractAddress, points: felt252) {
            let current_balance = self.balances.entry(user).read();
            assert(current_balance >= points, "Insufficient balance");
            self.balances.entry(user).write(current_balance - points);
            self.emit(PointsRedeemed { user: user, points: points });
        }

        fn get_balance(self: @ContractState, user: ContractAddress) -> felt252 {
            self.balances.entry(user).read()
        }
    }
}
