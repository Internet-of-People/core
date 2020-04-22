module.exports = {
    cli: {
        core: {
            run: {
                plugins: {
                    include: ["@arkecosystem/core-magistrate-transactions", "@internet-of-people/morpheus-hydra-plugin"],
                },
            },
        },
        relay: {
            run: {
                plugins: {
                    include: ["@arkecosystem/core-magistrate-transactions", "@internet-of-people/morpheus-hydra-plugin"],
                },
            },
        },
        forger: {
            run: {
                plugins: {
                    include: ["@arkecosystem/core-magistrate-transactions", "@internet-of-people/morpheus-hydra-plugin"],
                },
            },
        },
        chain: {
            run: {
                plugins: {
                    include: ["@arkecosystem/core-magistrate-transactions", "@internet-of-people/morpheus-hydra-plugin"],
                },
            },
        },
        snapshot: {
            run: {
                plugins: {
                    include: ["@arkecosystem/core-magistrate-transactions", "@internet-of-people/morpheus-hydra-plugin"],
                },
            },
        },
    },
};
