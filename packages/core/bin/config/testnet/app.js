module.exports = {
    cli: {
        core: {
            run: {
                plugins: {
                    include: ["@arkecosystem/core-magistrate-transactions", "@internet-of-people/hydra-plugin"],
                },
            },
        },
        relay: {
            run: {
                plugins: {
                    include: ["@arkecosystem/core-magistrate-transactions", "@internet-of-people/hydra-plugin"],
                },
            },
        },
        forger: {
            run: {
                plugins: {
                    include: ["@arkecosystem/core-magistrate-transactions", "@internet-of-people/hydra-plugin"],
                },
            },
        },
        chain: {
            run: {
                plugins: {
                    include: ["@arkecosystem/core-magistrate-transactions", "@internet-of-people/hydra-plugin"],
                },
            },
        },
        snapshot: {
            run: {
                plugins: {
                    include: ["@arkecosystem/core-magistrate-transactions", "@internet-of-people/hydra-plugin"],
                },
            },
        },
    },
};
